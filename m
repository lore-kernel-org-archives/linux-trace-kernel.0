Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261722B5BC;
	Tue,  8 Apr 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128210; cv=none; b=jmJr7ET4rmEXAv/kKQehs8VsHuUqdfodK+YKaRDHQo501RTpvNZa0OhF1+NUM3vYhvOBneSUOy310XjhcdPRojXz1mi1HtSVAl31Wyg/CC5vDv2ofMMwX9c5+P8Xe0Gf2c8pcblAWoB05mWc1JOQ3YbbYuRHUMSzEbrTcX/KhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128210; c=relaxed/simple;
	bh=zhPk8HSSBcaiiWP3jUwfn0byjqSwM7oiaQ+okmzORYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAKaUSz9lF1GY8XM4T1+gyxCqv947c4K29udupocT3xHs6uy2W0GSVqwFdXbKW6Qo4d6+QAu82jAcRsxwucA8QA270Qgzakfa1rRfcHNAzVbsJ72UsZ5fSVmZXRtJi3Nbut84EKZ+hhGmvhus44e5OiDMQcMkFpW1gnmk6JFJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSQODlrU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSQODlrU"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51e820336so5405667a12.1;
        Tue, 08 Apr 2025 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744128207; x=1744733007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJZssoxdYCurrja8QFrYZ1HhkVfLJVEPErYfFNVDT/c=;
        b=WSQODlrURux7U3cBo8vrOHGlidQ9v2aEtNRq9H30Ma/464WbX9x7iB9SAh2W8jx2aM
         THtOhtOX+7PT1BIEA5+8hFY2JYuPSNF8CLAZNqDypZFTKRp/r7pX2WNXwrdD7Li6EhFQ
         NgH6cEYDsBnIbeytAIPMdMdFZ9azR76Bc/JfAgncnDZPq+7585LH2r4bNn2635UXeS/e
         BTVFyDzEaNhZjIM3Pm8HArdJZq/Oqz0P+WI33w+odj615N0z7K0trPhl/+R0JjvrW+6Q
         RrgjfCdzh3fTpdL6vjIDNh6NiA8IquDDV5/C5yQNaPYGbJn6t0BnfDT60t6Zmf9BIVAh
         h0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744128207; x=1744733007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJZssoxdYCurrja8QFrYZ1HhkVfLJVEPErYfFNVDT/c=;
        b=NyqjNxuaNVeaSdYXR5cP9qeYgrldVl5ciX7i1yn796MiCzEmpAiu/eTIls4GXvkbI3
         PAnMOupUyWtncKrLS9GQXFLO4yhJoUiaUXg7sreBfyJvZt43bUoEsUHkSELLDxMg8Mmh
         1874XHBWnAiQfDGAptj8m2LcOp+Yv/qidD0reTRAsifp8nkhWTW5CsjgeVPjZLdZIjhd
         Y028FW/Cqkox3qLW3eVxg0U1Iu4jpsMYW5HrqCTQVaiRPIpKFYAgdTSg8k85NmSXSt0L
         wXuRoBD5r4EtbY7CLSkqrLLRSI0POD+eC/ZSh+b7vjXOq284bfZC17etPxcuQtOxvZHW
         OagQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvHITsUi44AD6foXfVItn1aVVZ4IkqEPjE/DrtQq3wNRZdXlQtJ6swBYIg7I3T25hr2jWybhVFxo2q3i3JGqpup3b7@vger.kernel.org, AJvYcCX0RqCaOGkCeVY6FjjgwqWdZJdioYJJDAUT01Gh0FpYHwTya9GAt4gHiiqGb2tJAOIsE+6XdKliEBHHyHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfKVcanqsEhAQDslzZNcbmMeb1CngAkj4roJ2QHLRjP3CMo9f
	Z5+Zno8TA/XmTpKckR6JEb/6fqfAPBnh+sq2Jlx5cXIQKbQvkhhaG1QCjeJm
X-Gm-Gg: ASbGnctqAwiyxnDE3ZUdSMJHtLSO8Xnd2AKEX1tDzGaqTO37nLU+ne/4HRnO+roQdJz
	IRFxndBDnlS+1FzOlKUHC/QyjsyAFprHw8gDPOhsC/rOt5ojzut37B69mr2nhuicawsHJt7370w
	LB99e2MT+JDyc5yjnddpmxEz798UcqBcWjNRfesMB+OdRWkPMdS5a7s0m2f7Dn3FxVFbZVednno
	nAwC/Ghkh5yHJuLx4z0wKE5gGbCEckdPrjalMy4xz+DGkrsVSrKk/aRdsi3qQvZsspVV0GlgePd
	09o8AEGVq+wQQyvpXMYaOUsXTRbiO6u/kLETafqNkDRSsu4MZGqoUZ+Bs1DaclSELyoqtKyoWF8
	dfoEKjjoBLG5khgxrMXg/PRVDccNeuzHoNQ==
X-Google-Smtp-Source: AGHT+IE2HewcejtZI3NO/WFe16jxsg9JFmJSVKcUYNwQkZ79YEaquztJowpwCkhH2ruVFF5IhK70zQ==
X-Received: by 2002:a17:902:fc50:b0:223:6455:8752 with SMTP id d9443c01a7336-22a95586abbmr178825445ad.43.1744128207506;
        Tue, 08 Apr 2025 09:03:27 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e5d7sm101977345ad.124.2025.04.08.09.03.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Apr 2025 09:03:26 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mark.rutland@arm.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	Andy Chiu <andybnac@gmail.com>,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vincent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH v2] ftrace: properly merge notrace hash
Date: Wed,  9 Apr 2025 00:02:57 +0800
Message-Id: <20250408160258.48563-1-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global notrace hash should be jointly decided by the intersection of
each subops's notrace hash, but not the filter hash.

Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
Changelog v2:
- free both filter and notrace hash when intersect_hash() fails
---
 kernel/trace/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..bb9e1bf4fe86 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3526,16 +3526,16 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
 		notrace_hash = EMPTY_HASH;
 	} else {
-		size_bits = max(ops->func_hash->filter_hash->size_bits,
-				subops->func_hash->filter_hash->size_bits);
+		size_bits = max(ops->func_hash->notrace_hash->size_bits,
+				subops->func_hash->notrace_hash->size_bits);
 		notrace_hash = alloc_ftrace_hash(size_bits);
 		if (!notrace_hash) {
-			free_ftrace_hash(filter_hash);
+			free_ftrace_hash(notrace_hash);
 			return -ENOMEM;
 		}
 
-		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
-				     subops->func_hash->filter_hash);
+		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
+				     subops->func_hash->notrace_hash);
 		if (ret < 0) {
 			free_ftrace_hash(filter_hash);
 			free_ftrace_hash(notrace_hash);
-- 
2.39.3 (Apple Git-145)

