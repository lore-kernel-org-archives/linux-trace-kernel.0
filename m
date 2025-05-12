Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F595246768
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067167; cv=none; b=FA9B6MddkOqq3brTEHJuIhHXXoZSkj5XvRflYAil0dmz5dheLQXrCDRcl4OMRSlpBz7+idMnsTLwsGNBEgG5kpsy9CDBIiiPOWmRc0VawktjpJhPl3SjOjEhBe2PtOtHe98GEwJZfQbuNqZHGjS1k4ZDt2c8fDRkRR3exRxaQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067167; c=relaxed/simple;
	bh=H80Hb5xHVpEesZfZTgxfcTyTauOTsmCECzY8+xNzrig=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VP1xtQIrjYm9IYFswrcxBtSujtneGOHlpmLUeGITKnvCrj+HKeR/o1nuITMB+0BVzKkeglAELWNhUT4ZazCrXOL5mG0nC/THY3TW97XfBY1BXb3hlqSOUcdQ2OK4PCxn6idXCZ90/jMfoiLQ/nmJDDInrE0ZxykFP0dYmKRjUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z91nh+cj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z91nh+cj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e39fbad5fso418475ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747067165; x=1747671965; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XMKDkkhdpogV8tIDl5TIG0t9G6/ip0D4CzjHNOWoPSs=;
        b=Z91nh+cjgRxtEB0LOEPnUL1v7pRCzK5rkK4qYagjDUGMeqbnyyTKhNVe9le0A70f8/
         IoAFsrxkzSmf2s8+HtICDlUaBoMAFF8cGUMNdXYVd0GwUoPOXpDGzlU5TEMm5yLN1RxM
         Kwb+UfwcAoA1tFHwAn008IrYnrcT2DpofQScATzuU57VfCuKcJcrnDA4WJyGpFtgpcIJ
         ljzsI6lP3GcPuLhVm16DMaZZxxgu0SSb2UK73+z/crrIw966MNbP+cTH7lEqwBTWOVYI
         dyXuaKCPJjDWc86ZhqlcgoNMQHQAvRa2TDQgPled3vr97UT7moGwsTTpwXex8Wre65nn
         1SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747067165; x=1747671965;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMKDkkhdpogV8tIDl5TIG0t9G6/ip0D4CzjHNOWoPSs=;
        b=USdzKUj9tNIUpZn6lJGYe+IPz17/0u/lxyTjtogDZyC52+uEj6MNm2Xs0kw3dZWbt8
         cZIX1ZKus7+MJ9/Y15pRNuHckCQD5xRlM0EV0fyauLOjbmNjQ4gzoJY8VwifsFAwSd31
         FyzN12E8wr6poGIIIGfadu3Vu3dMC1S+mlAg4bcWrGYdnep4iMAlpO8aCAJ+PIdGdDUb
         sn35s+sN9CqmBp3GhzyTUM1ddH0hLHIHm3m/NkaQmOEPpu6KZ2PI3IFFkjQI8S9AwRWv
         Oa1KwwrDrzVqQRj6zVP59F8kx6Zedw1aOh4WlYmYt4kc+I6p/SupCEhqSvPfl1osaYbz
         +vqg==
X-Forwarded-Encrypted: i=1; AJvYcCVCzu5otTcV2BvMqLn0nh9KZmnVCzent543wnQqoHjN8NGd4Je40kjMCr0799B5C4jSlvhK/FeP1zdZjZkD2Aih9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNz7kwqojUDLwSwASbGzo9JsCHOElOlB3AoMW0PHAYfnFInKK/
	L219vPRJ3NeT14We+3R4ubFMkDkBJFNKUDPgJ5/9wpC5fcvt4WdMqfbz8IN+Zg==
X-Gm-Gg: ASbGncvVNRxtTlNgdys74u2e99A4o+i57VyLhOz7ZRi4rvOWt14cK7rxvAt63tTRxl/
	EBOqQux8AyPXZX2lmzT77EGnigcqe92OwEumrD3FTUQSRCehv8BwCKdVH7mNnr5Z5BwpyqXfGHt
	xn4wcizNC2Vx0pCntxnaEVo0ymY8b9tUGuKOjjAWk/ezPMw2l8x7wbUKD44qrLm7SuHzhsagNrS
	PApFdRDF8U4E3ssEYIseRydqG22/Pv0B4aoaVVCTxuMRbvUEnONEw+r6VjxIAZsZy1lcbfwSM+f
	/Aed3m4kmauIb8fS/tJhTe9GR2HLD+Oi1gh2FvMti76j+lQn0nSKea68zkHFodbcAmaBvJlA+a7
	DdbbIwVvA2BD6/b2Sn120nj0joFAqJXtQd50sqpp6LnIZwg==
X-Google-Smtp-Source: AGHT+IGqqwVKDpcWRuVOsU9UDojhTYOTf0vdX5LjtvOaMjqF2g5rVTSK+cqsEEHkqmSuJySiCRXhPA==
X-Received: by 2002:a17:902:ccce:b0:220:c905:689f with SMTP id d9443c01a7336-22ff6e92960mr4143055ad.25.1747067164914;
        Mon, 12 May 2025 09:26:04 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:9bc7:4205:387d:fe54] ([2a00:79e0:2eb0:8:9bc7:4205:387d:fe54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829eb97sm64390655ad.215.2025.05.12.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:26:04 -0700 (PDT)
Date: Mon, 12 May 2025 09:26:03 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Amit Shah <amit@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Aneesh Kumar <AneeshKumar.KizhakeVeetil@arm.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Davidlohr Bueso <dave@stgolabs.net>, Hugh Dickins <hughd@google.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
    Kirill Shutemov <k.shutemov@gmail.com>, linux-mm@kvack.org, 
    Matthew Wilcox <willy@infradead.org>, Mel Gorman <mel.gorman@gmail.com>, 
    Michal Hocko <mhocko@suse.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>, 
    Raghavendra K T <rkodsara@amd.com>, 
    "Rao, Bharata Bhasker" <bharata@amd.com>, Rik van Riel <riel@surriel.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Shivank Garg <shivankg@amd.com>, 
    Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Yang Shi <shy828301@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Sweet Tea Dorminy <sweettea@google.com>, 
    Steven Rostedt <rostedt@goodmis.org>
cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: [Invitation] Linux MM Alignment Session on Hierarchical Per-CPU
 counters on Wednesday
Message-ID: <075013fa-f54f-e742-3c27-1b73f3e13a2c@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi everybody,

We host a biweekly series, the Linux MM Alignment Session, on Wednesdays.
We'd like to invite MM developers to attend and will announce the topic
for the next instance on the Monday prior to the next meeting.

Our next Linux MM Alignment Session is scheduled for Wednesday.  The
details:

Wednesday, May 14 * 9:00 - 10:00am PDT (UTC-7)
https://meet.google.com/csb-wcds-xya
backup: https://tel.meet/csb-wcds-xya?pin=1301132214803

This week's topic will be hierarchical per-cpu counters primarily aimed at 
optimizing RSS tracking led by Mathieu Desnoyers.  See the latest proposal 
at 
https://patchew.org/linux/20250410175149.1206995-1-mathieu.desnoyers@efficios.com/

If anybody has ideas for future topics, please let me know and I'll try to 
organize them.  We'd love to have volunteers to lead future topics as well 
as requests for MM topics to be presented.

Looking forward to seeing all of you on Wednesday!

Time zones

PDT (UTC-7)             9:00am
MDT (UTC-6)             10:00am
CDT (UTC-5)             11:00am
EDT (UTC-4)             12:00pm
Rio de Janeiro (UTC-3)  1:00pm
London (UTC+1)          5:00pm
Berlin (UTC+2)          6:00pm
Jerusalem (UTC+3)       7:00pm
Moscow (UTC+3)          7:00pm
Dubai (UTC+4)           8:00pm
Mumbai (UTC+5:30)       9:30pm
Singapore (UTC+8)       12:00am Thursday
Beijing (UTC+8)         12:00am Thursday
Tokyo (UTC+9)           1:00am Thursday
Sydney (UTC+10)         2:00am Thursday
Auckland (UTC+12)       4:00am Thursday
