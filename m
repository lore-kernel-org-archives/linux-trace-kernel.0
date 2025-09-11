Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4123E23C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564739; cv=none; b=kCoaVG+WbT11emrDGOQARFQsB6hPBuvbUryHPOnh24hjvw3dKNn4nV3PA9BURhk81Zym1RNtYx1AxY0OjQbY2vRyuM9v94u3OS/SOIN16iAaZOTE9OJDTwFA8AutJLyEV+Wzwb45zHhBPcOfTX3BnVSijnvu8Bfpb/WOa1UQysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564739; c=relaxed/simple;
	bh=hl9gq1aVXuk8SRq2FntgXVgpl5nqJXpU9YAPeHsAr1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyRxsJ64khaDXVvnqyLJO1YFqX89lP97AHcmYwz8N1mNHuRJnP6xgwXxVfNNl/Ged9UtVD2pSl7IX87A8L2O4mHUODdd3FyI4mkJtewMwXAqaRw5oC/MvR33tg+t+7OVoVaSRnzyyCaovBTweuA0XJlRJT+roGwuERZgCqdKpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4/xmLa6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4/xmLa6"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso233218b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564737; x=1758169537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8cx1zbULZi9TOGMtPIQBsOoQknNuGF4AGIQhvpTYsw=;
        b=H4/xmLa6oG84ajd46FBk2UCh4fBmI4MaAkTKcZ0y1XtcbIYoFnFXtgdEmmYLZE8uDz
         Bmma2gpzcevItkoLzmfAL0w9V7n1TxuZHagd2hYC5eS8BdTs3ZSbU69L5NVmwy/BafAa
         0G0zzZE+5p4wkNpWVV7QYfJjgxk0G+OdDRWAImIA047gHwq/SXeX8aCWxQ1uBqjZkmj5
         5m1F6IYbqeDhVcsIsnR6sxYxZaClvDAJ+IExMWu0HWzoqy7/hOKBc6So+TyyD9rfT+Gr
         VWzWBNlEEi9H4IxVcq68mQT4qbOBVTZv8ok7xf2/zw2w/cQr5SZRe39ac4WPPZpd5aIZ
         q7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564737; x=1758169537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8cx1zbULZi9TOGMtPIQBsOoQknNuGF4AGIQhvpTYsw=;
        b=ZrTyOA/yKKF4/AuVCTutkL+GRWvtx4ex2dwdi3MflD3bZR8DYAdgI5A4tAcLOyXMhE
         jqQKAxxmb37M3vGeNJaIerrIateV3kWL/Ok6JtXPoLFIX5AJvjGkl/uyWhuOYSzysfA/
         NZHbkGy/jVLeI0Q32btUBwKIyVwNuOsOR7h8Mgwlxn+8jyq9s+hNlbay8yBaPmL6FEeL
         GwrRoiMesYsqU+JkawdlEiJ9X3yzDX+VD0qjuqb4S9My4E/rEz5rApNviypn2V8KJWBJ
         wZKTGV55x/XNYuePD8nbdAg7W9nOccbO+1OxnIrZmbAp9mrHgBhZvRYaz4qbhR1utVMp
         /PHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKsYOsxXZ3nik3GQF12HrAnnHFlJ/2v6vNZY3dZIA4meX8Ho/Xq3ZrrbJJTHJ85aiv8Lk3xpolVfWpRvViap5ncTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXD41nzbuHhFfkEw3+S7/eKp5NaN8vM74h5pR7keSt+1dgjKkI
	TVzhAm2eTjxdFLonMKxg1pyVlLpbNGSIrklEGtNWiLtSgGPAiX1bdZ1y
X-Gm-Gg: ASbGncvs39ZPh1v5BMhAL+xTyIiLWZID/CobrkEeiZxBd4sW1KY1eSTne9X6w04DlYN
	WmVvFnBaP6gWH0mMJS7+c1sY5+3l5Z7t3RAGfLoEtrwm5cNtgpJmMltmwon2HhDqSMis/sDv82x
	NK5SdoYyQFrxTXdZJXsSN4RZ9q5KGNbXGZTszHMNKQ7pUj2admy9UvUGjM6l+39ZCC34/1O4DVK
	ZcUdu08kVRkdzQvgm0ot/q2A/o8F6fqM3RnEmowSmwhzwBXySK1hP4avSxe7SWf5MYrAfJl6cod
	nkgV2dEZN0/eOclkfguxCid7u6w3+rg+JxK5HOElzUi87SMqiL+iE67ddO3cOOIgK0jLZ9EmJ+S
	KftMLNF254V4I69RK9XnB7P7fSQ==
X-Google-Smtp-Source: AGHT+IHFeAEcp1B2iG22bZPXc/H4UpsCLlKZ1M5MBs+0Pe5NMvWliNuhRFMVGkEGFC+Kdx3M7xzPFw==
X-Received: by 2002:a05:6a00:4655:b0:772:5487:c37c with SMTP id d2e1a72fcca58-7742de3fc65mr22594988b3a.22.1757564736754;
        Wed, 10 Sep 2025 21:25:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4746dsm535936b3a.29.2025.09.10.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 828E441FA3A1; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/5] Documentation: trace: histogram-design: Trim trailing vertices in diagram explanation text
Date: Thu, 11 Sep 2025 11:25:24 +0700
Message-ID: <20250911042527.22573-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911042527.22573-1-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12012; i=bagasdotme@gmail.com; h=from:subject; bh=hl9gq1aVXuk8SRq2FntgXVgpl5nqJXpU9YAPeHsAr1k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/M7PKhJjK5ratuHySrlNd+t/Tb+wY3brhsiV7ZNiX j+6dPa3aEcpC4MYF4OsmCLLpES+ptO7jEQutK91hJnDygQyhIGLUwAmckiJkWEn54TXDLnuMwT+ HPaveyngeNfLm+H+l3+XxDobb0+fsrKPkWHrQ6PPM/heCc1xWnE/WrD9uF7J6m11bX1RUr3T3uw z/8EPAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Diagram explanation text is supposed to be interleaved commentary
between diagram parts that are spread out, but it outputs ugly in
htmldocs due to trailing vertices as if both the explanation and the
diagram are in the same literal code block.

Trim trailing vertices.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram-design.rst | 138 +++++++++++------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 5765eb3e9efa78..231a12bd7d461c 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -142,30 +142,30 @@ elements for a couple hypothetical keys and values.::
                              +--------------+                            |  |
                                             n_keys = n_fields - n_vals   |  |
 
-The hist_data n_vals and n_fields delineate the extent of the fields[]   |  |
-array and separate keys from values for the rest of the code.            |  |
+The hist_data n_vals and n_fields delineate the extent of the fields[]
+array and separate keys from values for the rest of the code.
 
-Below is a run-time representation of the tracing_map part of the        |  |
-histogram, with pointers from various parts of the fields[] array        |  |
-to corresponding parts of the tracing_map.                               |  |
+Below is a run-time representation of the tracing_map part of the
+histogram, with pointers from various parts of the fields[] array
+to corresponding parts of the tracing_map.
 
-The tracing_map consists of an array of tracing_map_entrys and a set     |  |
-of preallocated tracing_map_elts (abbreviated below as map_entry and     |  |
-map_elt).  The total number of map_entrys in the hist_data.map array =   |  |
-map->max_elts (actually map->map_size but only max_elts of those are     |  |
-used.  This is a property required by the map_insert() algorithm).       |  |
+The tracing_map consists of an array of tracing_map_entrys and a set
+of preallocated tracing_map_elts (abbreviated below as map_entry and
+map_elt).  The total number of map_entrys in the hist_data.map array =
+map->max_elts (actually map->map_size but only max_elts of those are
+used.  This is a property required by the map_insert() algorithm).
 
-If a map_entry is unused, meaning no key has yet hashed into it, its     |  |
-.key value is 0 and its .val pointer is NULL.  Once a map_entry has      |  |
-been claimed, the .key value contains the key's hash value and the       |  |
-.val member points to a map_elt containing the full key and an entry     |  |
-for each key or value in the map_elt.fields[] array.  There is an        |  |
-entry in the map_elt.fields[] array corresponding to each hist_field     |  |
-in the histogram, and this is where the continually aggregated sums      |  |
-corresponding to each histogram value are kept.                          |  |
+If a map_entry is unused, meaning no key has yet hashed into it, its
+.key value is 0 and its .val pointer is NULL.  Once a map_entry has
+been claimed, the .key value contains the key's hash value and the
+.val member points to a map_elt containing the full key and an entry
+for each key or value in the map_elt.fields[] array.  There is an
+entry in the map_elt.fields[] array corresponding to each hist_field
+in the histogram, and this is where the continually aggregated sums
+corresponding to each histogram value are kept.
 
-The diagram attempts to show the relationship between the                |  |
-hist_data.fields[] and the map_elt.fields[] with the links drawn         |  |
+The diagram attempts to show the relationship between the
+hist_data.fields[] and the map_elt.fields[] with the links drawn
 between diagrams::
 
   +-----------+		                                                 |  |
@@ -440,31 +440,31 @@ sched_waking histogram
                                              n_keys = n_fields - n_vals   | | |
                                                                           | | |
 
-This is very similar to the basic case.  In the above diagram, we can     | | |
-see a new .flags member has been added to the struct hist_field           | | |
-struct, and a new entry added to hist_data.fields representing the ts0    | | |
-variable.  For a normal val hist_field, .flags is just 0 (modulo          | | |
-modifier flags), but if the value is defined as a variable, the .flags    | | |
-contains a set FL_VAR bit.                                                | | |
+This is very similar to the basic case.  In the above diagram, we can
+see a new .flags member has been added to the struct hist_field
+struct, and a new entry added to hist_data.fields representing the ts0
+variable.  For a normal val hist_field, .flags is just 0 (modulo
+modifier flags), but if the value is defined as a variable, the .flags
+contains a set FL_VAR bit.
 
-As you can see, the ts0 entry's .var.idx member contains the index        | | |
-into the tracing_map_elts' .vars[] array containing variable values.      | | |
-This idx is used whenever the value of the variable is set or read.       | | |
-The map_elt.vars idx assigned to the given variable is assigned and       | | |
-saved in .var.idx by create_tracing_map_fields() after it calls           | | |
-tracing_map_add_var().                                                    | | |
+As you can see, the ts0 entry's .var.idx member contains the index
+into the tracing_map_elts' .vars[] array containing variable values.
+This idx is used whenever the value of the variable is set or read.
+The map_elt.vars idx assigned to the given variable is assigned and
+saved in .var.idx by create_tracing_map_fields() after it calls
+tracing_map_add_var().
 
-Below is a representation of the histogram at run-time, which             | | |
-populates the map, along with correspondence to the above hist_data and   | | |
-hist_field data structures.                                               | | |
+Below is a representation of the histogram at run-time, which
+populates the map, along with correspondence to the above hist_data and
+hist_field data structures.
 
-The diagram attempts to show the relationship between the                 | | |
-hist_data.fields[] and the map_elt.fields[] and map_elt.vars[] with       | | |
-the links drawn between diagrams.  For each of the map_elts, you can      | | |
-see that the .fields[] members point to the .sum or .offset of a key      | | |
-or val and the .vars[] members point to the value of a variable.  The     | | |
-arrows between the two diagrams show the linkages between those           | | |
-tracing_map members and the field definitions in the corresponding        | | |
+The diagram attempts to show the relationship between the
+hist_data.fields[] and the map_elt.fields[] and map_elt.vars[] with
+the links drawn between diagrams.  For each of the map_elts, you can
+see that the .fields[] members point to the .sum or .offset of a key
+or val and the .vars[] members point to the value of a variable.  The
+arrows between the two diagrams show the linkages between those
+tracing_map members and the field definitions in the corresponding
 hist_data fields[] members.::
 
   +-----------+		                                                  | | |
@@ -565,40 +565,40 @@ hist_data fields[] members.::
                                                       |               |     | |
                                                       +---------------+     | |
 
-For each used map entry, there's a map_elt pointing to an array of          | |
-.vars containing the current value of the variables associated with         | |
-that histogram entry.  So in the above, the timestamp associated with       | |
-pid 999 is 113345679876, and the timestamp variable in the same             | |
-.var.idx for pid 4444 is 213499240729.                                      | |
+For each used map entry, there's a map_elt pointing to an array of
+.vars containing the current value of the variables associated with
+that histogram entry.  So in the above, the timestamp associated with
+pid 999 is 113345679876, and the timestamp variable in the same
+.var.idx for pid 4444 is 213499240729.
 
-sched_switch histogram                                                      | |
-----------------------                                                      | |
+sched_switch histogram
+----------------------
 
-The sched_switch histogram paired with the above sched_waking               | |
-histogram is shown below.  The most important aspect of the                 | |
-sched_switch histogram is that it references a variable on the              | |
-sched_waking histogram above.                                               | |
+The sched_switch histogram paired with the above sched_waking
+histogram is shown below.  The most important aspect of the
+sched_switch histogram is that it references a variable on the
+sched_waking histogram above.
 
-The histogram diagram is very similar to the others so far displayed,       | |
-but it adds variable references.  You can see the normal hitcount and       | |
-key fields along with a new wakeup_lat variable implemented in the          | |
-same way as the sched_waking ts0 variable, but in addition there's an       | |
-entry with the new FL_VAR_REF (short for HIST_FIELD_FL_VAR_REF) flag.       | |
+The histogram diagram is very similar to the others so far displayed,
+but it adds variable references.  You can see the normal hitcount and
+key fields along with a new wakeup_lat variable implemented in the
+same way as the sched_waking ts0 variable, but in addition there's an
+entry with the new FL_VAR_REF (short for HIST_FIELD_FL_VAR_REF) flag.
 
-Associated with the new var ref field are a couple of new hist_field        | |
-members, var.hist_data and var_ref_idx.  For a variable reference, the      | |
-var.hist_data goes with the var.idx, which together uniquely identify       | |
-a particular variable on a particular histogram.  The var_ref_idx is        | |
-just the index into the var_ref_vals[] array that caches the values of      | |
-each variable whenever a hist trigger is updated.  Those resulting          | |
-values are then finally accessed by other code such as trace action         | |
-code that uses the var_ref_idx values to assign param values.               | |
+Associated with the new var ref field are a couple of new hist_field
+members, var.hist_data and var_ref_idx.  For a variable reference, the
+var.hist_data goes with the var.idx, which together uniquely identify
+a particular variable on a particular histogram.  The var_ref_idx is
+just the index into the var_ref_vals[] array that caches the values of
+each variable whenever a hist trigger is updated.  Those resulting
+values are then finally accessed by other code such as trace action
+code that uses the var_ref_idx values to assign param values.
 
-The diagram below describes the situation for the sched_switch              | |
+The diagram below describes the situation for the sched_switch
 histogram referred to before::
 
-  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0' >>     | |
-          events/sched/sched_switch/trigger                                 | |
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0' >>
+          events/sched/sched_switch/trigger
                                                                             | |
   +------------------+                                                      | |
   | hist_data        |                                                      | |
-- 
An old man doll... just what I always wanted! - Clara

