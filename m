Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6B2E9EC6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863348; cv=none; b=QmpUJspAhnl6eXxqqbgyzxM21eoepqmwW4toGNxvS+QKurAuefbUC/shoZLHubYljGStcrb7igvKvWSqalYGXCG+yc7gNVE5S9U8oLAreIsqTaI/TLHxnLM4M1U2i8cx9P2zSNc8F9tmwoegeM0usG1s+O10cEqPd9ISMrYBPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863348; c=relaxed/simple;
	bh=L9zt2+mYIjZagYVVaj6OPHVn0B0rNs3RIPv8NtxcOPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGxWHno9KIkr8NqlOBoGGNaYq78CvXbiL/+emmo9H0cTSVOgy04cy4ke/gB0A2wGIizL/3evaO2qg2J6oRtK9m9fSwKY2y+MHv3z54EKUvcCA00ScEHqcXC4sqHsAYzRtM5hWbCPQgFRGhxL+uDOHP0/pf1Nl+RWXNNnSv8dvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP2BNvKF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP2BNvKF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28832ad6f64so75866015ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863347; x=1760468147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEHJ86/7N3GoML0TX8U7iEmW2mKzHnR6gQNQcuV/G5Y=;
        b=PP2BNvKFj5gX6YhSJsPFuSSJNTvmLp3+TfvXC7KdFLq30aSCsG3MTporEK3E5UTB7j
         3BIndZGFzF+2Li7lbjN1JJ0kOFFCx5DKO2Rf0y4qGwbFfFpFOuxKoo3Zbva8DVeUluWa
         zHMx9U7kMbDlubajnTdzpyaOhu/47cBFRMU5KiMxq1ludhjfZCe6dk4j3Ed0yBjKzRFK
         6uPkNL0SI1qs+jaO4i2ple7VN/gY12LD9qx3Ib+0scFDrT+SFvM7GMULBxvmm9buZ7e2
         qzGCVxgN7LHT6ZIfhuo7i+FO2CIhlO5PXBAH/wbVZPnLwbIgAuhMb3fPYOCN66O0BSIv
         SsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863347; x=1760468147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEHJ86/7N3GoML0TX8U7iEmW2mKzHnR6gQNQcuV/G5Y=;
        b=CCmkhvmD3jkDxTXgqGWLGZRbomBwydtbgwDW8QM2thpGFTdRWMrwI1a7nsL7x4l2fW
         6gVu/2oLDV1xDliY/oYDf3OBNXfO/Ma4e1YybS15unhB1Ia4jR13rrkoi6c8pIBoz8PV
         /Pqgtcl6dF8VprQDPf5kv3GnXBK7d89d322EhyFQezY0G3oY7LdNTV+yPgF9DwPV6IRG
         w6+/CSlL761Ha6H1JnoBP2Bf6D590fjkHcbNPby0NK2302MO2JPWwQfHFAcY7UHOT9io
         2h1k/W1IjbZ/8Q5DBDjXjVPAFyPRUJZBBVYqYYuh2JZiaLeE2oMtzC7OhgIqc6GNPzTq
         W9vw==
X-Forwarded-Encrypted: i=1; AJvYcCUBfTqqbc2AkfeVglI3b1NwuSFn8DKhRoumGAsccAlar+Kfn7pL1wHNZ78inoLzA6sdWE+y19JWiY/4dlLw6bHxpVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0XpieabBtJ2C7P5ZT95eBob+S+XillsEMS6UrtwEagj1PJ24
	T1HNC7mu5eD0T+y+yYNzDkz7dAHNcxUbfKogHM+/zUbEGYoVOFye8oNU
X-Gm-Gg: ASbGncufnz7d7DMlqlyw3DjFWB/1zyv/lAHqSn/MsBlLNMADIrQFNpckI5+NH4HHgB9
	XL4FKckG3u60JtWd9S2V+MUIUqUCXGbLoIJcIdRNmypG5pndO7zcY1+LjvgBH+caT/6Y2gzg1dl
	PP1Ei5eB0gjojDD4ivYJweTiHfoz/n1StlyoKo2njItuqUZFhuijkJ5qoDJVv99O0Y6MiK0n+XR
	oqBLaprKUJNpfjrvztdecutJ05L8X0T6dBjRARykRpjOoQTkvWQ0zK+zvI5SV1ugLjBCp5/btX3
	Cm1pL/avoz/FLUrBd/VNcUzLunJGEiwy+eW7DJZLeK0cTOlPGJu4D9J3cigoICnnkAOvH4ST0cv
	rzoEemuEiL0j8FSQCIUMUCexMC+3odqiLonSaSS5/UtERz1PnP1kErksyWnr/e43wxQ==
X-Google-Smtp-Source: AGHT+IFtTvflDnDVga6tSkVQUnvou1LUWOf9MCJHjvLvWiRbsFrn5VG8YDKujN10eze6W/WhgJGaUQ==
X-Received: by 2002:a17:903:19e5:b0:27e:ef35:2dbf with SMTP id d9443c01a7336-290272c1c46mr8620475ad.30.1759863346715;
        Tue, 07 Oct 2025 11:55:46 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:46 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/8] Documentation/rtla: rename common_osnoise_description.rst
Date: Wed,  8 Oct 2025 00:24:52 +0530
Message-ID: <20251007185508.40908-4-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_osnoise_description.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_osnoise_description.rst to common_osnoise_description.txt
to maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...n_osnoise_description.rst => common_osnoise_description.txt} | 0
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-osnoise.rst                       | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)

diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_description.rst
rename to Documentation/tools/rtla/common_osnoise_description.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index a39285817566..55616085275e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The **rtla osnoise hist** tool collects all **osnoise:sample_threshold**
 occurrence in a histogram, displaying the results in a user-friendly way.
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 58321322d24e..ea0e9f5a5c0a 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 **rtla osnoise top** collects the periodic summary from the *osnoise* tracer,
 including the counters of the occurrence of the interference source,
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index 997a981fe397..540d2bf6c152 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The *osnoise* tracer outputs information in two ways. It periodically prints
 a summary of the noise of the operating system, including the counters of
-- 
2.43.0

