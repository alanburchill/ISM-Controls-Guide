---
layout: default
title: ISM Controls Implementation Guide
---

# ISM Controls Implementation Guide

Implementation guidance for Australian Information Security Manual (ISM) controls with Essential Eight and PSPF mappings.

<div id="filters" style="margin-bottom: 20px; padding: 15px; background: #f5f5f5; border-radius: 8px;">
  <div style="display: flex; flex-wrap: wrap; gap: 15px;">
    <div>
      <label for="filter-e8"><strong>Essential Eight:</strong></label><br>
      <select id="filter-e8" onchange="applyFilters()">
        <option value="">All Levels</option>
        <option value="ML1">ML1</option>
        <option value="ML2">ML2</option>
        <option value="ML3">ML3</option>
      </select>
    </div>
    <div>
      <label for="filter-pspf"><strong>PSPF Level:</strong></label><br>
      <select id="filter-pspf" onchange="applyFilters()">
        <option value="">All Levels</option>
        <option value="NC">NC</option>
        <option value="OS">OS</option>
        <option value="P">P</option>
        <option value="S">S</option>
        <option value="TS">TS</option>
      </select>
    </div>
    <div>
      <label for="filter-section"><strong>Section:</strong></label><br>
      <select id="filter-section" onchange="applyFilters()">
        <option value="">All Sections</option>
      </select>
    </div>
    <div>
      <label for="filter-topic"><strong>Topic:</strong></label><br>
      <select id="filter-topic" onchange="applyFilters()">
        <option value="">All Topics</option>
      </select>
    </div>
  </div>
  <div style="margin-top: 15px;">
    <input type="text" id="search-input" placeholder="Search controls..." style="width: 100%; max-width: 400px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
    <button onclick="clearFilters()" style="margin-left: 10px; padding: 8px 16px; cursor: pointer;">Clear All</button>
  </div>
  <div style="margin-top: 10px;">
    <span id="result-count">Loading...</span>
  </div>
</div>

<table id="controls-table" style="width: 100%; border-collapse: collapse;">
  <thead>
    <tr style="background: #0366d6; color: white;">
      <th style="padding: 10px; text-align: left;">ISM Control</th>
      <th style="padding: 10px; text-align: left;">Title</th>
      <th style="padding: 10px; text-align: left;">Section</th>
      <th style="padding: 10px; text-align: left;">E8</th>
      <th style="padding: 10px; text-align: left;">PSPF</th>
    </tr>
  </thead>
  <tbody id="controls-body">
    <tr><td colspan="5" style="padding: 20px; text-align: center;">Loading controls...</td></tr>
  </tbody>
</table>

<script>
let allControls = [];

// Load the search index
fetch('{{ site.baseurl }}/assets/search_index.json')
  .then(response => response.json())
  .then(data => {
    allControls = data;
    populateFilterDropdowns();
    renderTable(allControls);
  })
  .catch(err => {
    document.getElementById('controls-body').innerHTML = 
      '<tr><td colspan="5" style="padding: 20px; color: red;">Error loading controls. Please refresh.</td></tr>';
    console.error('Failed to load search index:', err);
  });

function populateFilterDropdowns() {
  const sections = [...new Set(allControls.map(c => c.section).filter(Boolean))].sort();
  const topics = [...new Set(allControls.map(c => c.topic).filter(Boolean))].sort();
  
  const sectionSelect = document.getElementById('filter-section');
  sections.forEach(s => {
    const opt = document.createElement('option');
    opt.value = s;
    opt.textContent = s;
    sectionSelect.appendChild(opt);
  });
  
  const topicSelect = document.getElementById('filter-topic');
  topics.forEach(t => {
    const opt = document.createElement('option');
    opt.value = t;
    opt.textContent = t;
    topicSelect.appendChild(opt);
  });
}

function applyFilters() {
  const e8 = document.getElementById('filter-e8').value;
  const pspf = document.getElementById('filter-pspf').value;
  const section = document.getElementById('filter-section').value;
  const topic = document.getElementById('filter-topic').value;
  const search = document.getElementById('search-input').value.toLowerCase();
  
  let filtered = allControls.filter(control => {
    if (e8 && (!control.essential_eight || !control.essential_eight.includes(e8))) {
      return false;
    }
    if (pspf && (!control.pspf_levels || !control.pspf_levels.includes(pspf))) {
      return false;
    }
    if (section && control.section !== section) {
      return false;
    }
    if (topic && control.topic !== topic) {
      return false;
    }
    if (search) {
      const searchable = [
        control.title,
        control.ism_control,
        control.content,
        control.section,
        control.topic
      ].filter(Boolean).join(' ').toLowerCase();
      if (!searchable.includes(search)) {
        return false;
      }
    }
    return true;
  });
  
  renderTable(filtered);
}

function renderTable(controls) {
  const tbody = document.getElementById('controls-body');
  document.getElementById('result-count').textContent = `Showing ${controls.length} of ${allControls.length} controls`;
  
  if (controls.length === 0) {
    tbody.innerHTML = '<tr><td colspan="5" style="padding: 20px; text-align: center;">No controls match your filters.</td></tr>';
    return;
  }
  
  tbody.innerHTML = controls.map(control => {
    const e8Display = control.essential_eight ? control.essential_eight.join(', ') : '-';
    const pspfDisplay = control.pspf_levels ? control.pspf_levels.join(', ') : '-';
    // Update path to point to controls folder
    const url = '{{ site.baseurl }}/controls/' + control.path.replace('output/answer/', '');
    
    return `<tr style="border-bottom: 1px solid #eee;">
      <td style="padding: 10px;"><a href="${url}">${control.ism_control || '-'}</a></td>
      <td style="padding: 10px;"><a href="${url}">${control.title || 'Untitled'}</a></td>
      <td style="padding: 10px;">${control.section || '-'}</td>
      <td style="padding: 10px;">${e8Display}</td>
      <td style="padding: 10px;">${pspfDisplay}</td>
    </tr>`;
  }).join('');
}

function clearFilters() {
  document.getElementById('filter-e8').value = '';
  document.getElementById('filter-pspf').value = '';
  document.getElementById('filter-section').value = '';
  document.getElementById('filter-topic').value = '';
  document.getElementById('search-input').value = '';
  renderTable(allControls);
}

document.getElementById('search-input').addEventListener('input', applyFilters);
</script>
