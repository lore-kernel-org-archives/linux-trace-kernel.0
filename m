Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE23AEF44
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428847; cv=none; b=LR/XljybltOQQLHfi2UOBwwfqtZDmSUAELT/jxKa51Bxc7zfXWgW5Ej2ec8xlhy1yOvn+TQUUcvni14DiGEJlzIzBrR9qpHThAJqFrql3VqISwtFayy0SMa8lP9Ra5Xp4H4rfjnzUY1d99wkswvzN5rjTBUP9rPcOQLw727mIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428847; c=relaxed/simple;
	bh=A8Qn2ZXNyjvn8gNDuWwA+Rtb50kD3BeNv2696tgjRjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pad0hFQSUcZd3/jAYKwk3AsBemOpkn23ROm6m+FTgOiQijuHpBU4SwvNQ63D5JI6+//XZW2CoMxpOK97nHxGe6LW1DkysJhF0+6W2ZSGoLLjg3z4e8edj6KkCWbXNzDuA0nTPYK9hDh/hI0oOYM4YfnnkeNcgXsVu+JQoyT1Mk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkFSUbeM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkFSUbeM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c52c67f64cso32088385a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428828; x=1769033628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVTV9saCiqOGcBv4/N1kZOQdjcejYiLRdluYVStkd9M=;
        b=KkFSUbeMrfhGDKaMkcBs1gAfFq6i4S05xZsadrVDqLIjDc58XprImxwIwuuNeNYowF
         gP+Dc3oOBEHLBWJ81YZvIZaYPHFQZJS/eayyUVt8WEBjMGAPf+g67kQ9sLe9rZ8XRJpC
         BkQLHHCsA/+9pCdqroGPtuAeuaeLK781dhZcGJeKNh89MKrdzUyQJjwT1Vd9IsV4esIl
         upz8N1YbOjI3Ll11oaCts5RgRnZCVhFv4w5JTiwfmDoabFCGYX5snatjYlW+qIlSAJnW
         TL2us52c6ZFX5vPc1RescPzu1E/6IYJvM+9JxAPgKIJm+Gcuqu+ryoyML14NrM84S/ii
         YIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428828; x=1769033628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVTV9saCiqOGcBv4/N1kZOQdjcejYiLRdluYVStkd9M=;
        b=uafVq+xKSJ24Y3RQIE4OVU9MMuOUHmdRIBhbLcbHiGZW8DQFHTPf6J6Sfk2Jn9LDeD
         u8WftiCdZwE4sXigQ7ZpLmil9HGH9zjm/vKIH7+9sf3B/3OyD7L98vUmiyB7zSyMTlf2
         xhJIZxcNifhb6lCjKJ9HeMb7awGrr4yKADA40IWM8yzrb5jOCosM1U6W/p/W7cDJk4y9
         gjCqX/Pys/Xq2Fo3Ll0uPrLhLJq9XvmQcFTYR1GdZf9L5sL4v8BA1vZ9jUAe01a+GJwy
         e3iMFqcyhHOZ2nJvddiL18dbDDA+KdG/p/CFCebKw4bhoGba0zW39o4F0SfFI0sNwvSm
         ugUg==
X-Forwarded-Encrypted: i=1; AJvYcCU0+VP/wTcYPRVXkFDsuE+rwUqdV2IfOxYPzRuvBNVtiAsbF7fcaCVocITGSOvVhhfnGaLN8gQ79b7zBILktiEw2xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5839BfRNsrimaiVmtIaRBTS5kcw/mwgsuSPx3T147crC4P5qX
	zTQqzaTEC3pVvQWpyAf12OkcJw6S9eoAyPzqlPDA96Ihk5LlB5u3Yc3p
X-Gm-Gg: AY/fxX6+o3JLxEaLLXAIcEvIXIAWvcD+t1nHb7w5PqQ8fKwlDghNgDGjJiF4gbTKdIG
	IJLmfL+eDOJ9p3MbG/nZ+hyRCt5MIhuTzULb49qLWvC0RqDG97aDrnSkgPEeCRzoQHSy/UR5kA2
	8gm9d0TaMZK3WOUgMdApq4KG4PI45xkqmn4qMWO3vgLYxrpW1/Xhb/1bVlnn0LsLLYmgY8ubTjd
	kN8Nj3AD+IuQZutsdRpdsq/CG/tc81Pbbwc5EDAv/S71blc4DCuEgWJTDtfUI07l3TjqGfUcF9B
	LOIEDCmmjKTj7u+wJgHe/gvrY0jCOHFSxs5tRFvhoOgrjpnIUKFuVcJGVejDtW+PPMsMJL+p2LH
	OqfYe2jsWFMe4hyLP8JsQKYVSFtgCcD7Oa90tXIbGkAVBuqqJlfq/ZGr1loZHLXz4PbIKT6yQK1
	0JJ3HCxVUJ/2229g++zpj4fTXKs1Pl7FyYxget1GMT8pWSn3IKBHeJr5MO8/bhHKAsi1np+zeki
	rpvNcv7vw==
X-Received: by 2002:a05:620a:2946:b0:8c6:670c:953f with SMTP id af79cd13be357-8c6670c9641mr44853285a.58.1768428828498;
        Wed, 14 Jan 2026 14:13:48 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:48 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Wed, 14 Jan 2026 17:13:40 -0500
Message-ID: <20260114221341.128038-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
 <20260114221341.128038-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
index 45e57c6f487d..79392e268929 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event list syntax and :entry/:exit suffixes
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-list>[:entry|:exit] [<args>]":README
 
 # Setup symbols to test. These are common kernel functions.
 PLACE=vfs_read
-- 
2.43.0

