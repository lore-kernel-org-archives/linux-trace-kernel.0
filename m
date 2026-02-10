Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADD31D372
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723298; cv=none; b=s5FO38MaqOIJDa60v7JtyK+2mzgBuqHzQ6fprgltXgu4e08LcnVhidxwXMsoYmAO995SJeYsUBHC/VMS6oUwQRB8AioQAfVjsvAVp21qB5Al1Bfo2K4Yuvrg2hhyKkGhTrn34L/QgNEFrPJ+UTlISAXaI5/ev9pBrD+tAzdOFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723298; c=relaxed/simple;
	bh=zJ2Q3ZfXvTejXn7hADjwCYUmn97smDDde070ENCFaMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udC2sN6ugZQ6KEsOTUJ40cBiYLzuExOBiacLMInArj1LA7fcAPEhSe4+a5ggBFW4Sx2UOZpJyH0C8Vk2czND20MulAV6pvnUz/wP7hvkbIDV+YBNb4J26zk+TlPQJSaIxTvNQDJ5l9Ei+jUlYQcdFJiM03o/CWzm3HxYLvhEs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QJ3JGM3b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QJ3JGM3b"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so52470095e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723292; x=1771328092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n6tcTGOKkQhPa3J8Fp7f0Ik4WwCbQupTIGbvUZ9CRk=;
        b=QJ3JGM3b80e9zy/zZ5wDtoyJ8q04BkBmPKGDwzl/uaqiNsUM4B+b+YdmqooqMT+g7B
         dttALfLPl4eqcF9MciCVKB4X5bGj9cSz3qxl86NETEKhEvE99Az3YolPMdGJoyvpf8Pe
         Le9zLOWb8DXiXzzjMj8Zkl+iXyMLI9UvJm939PHP6IfGAmJsd0YeiaGrnzHs/c9d1j+9
         es3eDIV7olXgTKz5GRDROBF6TJXeeoBljzllJdT4ZDnQmyZxaCGM5NEgPrI1aM//UdSO
         mvjAbZXFv7vj/Wy4WBtzKvVQ8J3aCmZs1Es5vz4LFV1Nv2uILrPqWwI0o8w+rFPOZpea
         UwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723292; x=1771328092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7n6tcTGOKkQhPa3J8Fp7f0Ik4WwCbQupTIGbvUZ9CRk=;
        b=RKWKoC5kmgYlrDbWqSbtBq+jaQUWP0OesvWO76oAGBhu4m+Hn9MnrNOF+BDxCYU2TL
         y+D4WiTp+KnFg8FrXwPv3alZoAk16t2cJhSTQsaVMZCZtsob7HyTVQGenApLStYuxj0S
         eGq5oCts/xy2un3vY2hL+iDzI63ifTmDkbYCOZC+Z7qL5lexNhFsv5ZeKOYEXPbR9OZj
         LUgvm5mSWYz3IFgn0yfJj8G46mAWW3CgtruPE5Oj/74OvO8uNxU9zXIZy9k5Zg7FfQ61
         0cl7OopRt+TGhVGbB6YfAy1sFGAY0Jx1Y2a3lYZeGaBcQGJpT5waPO+N/zBelmwKcmmS
         ipWg==
X-Forwarded-Encrypted: i=1; AJvYcCWAYpMrhvWbxr+FPdsKiLxM8c/fwnva0Ff0BV5ipOQWYZo6xNxjjkeiH+TfLey8cRkatsdFxdlqQ1A3hve9xE0+7z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/ia4BafKLQrh4JxkE5/ZPzMugspV2w+WzRzlYYsxcNjnt4KW
	x02dhwGm+haKMkmw6f2nqPHJSD0tYB7mksZjAEzXkLW+rKZs61Us8YTiQj8/HKS5qm2PNofm0Tf
	iZZqM
X-Gm-Gg: AZuq6aIMudqYmtKsxNLQvmTvxmV1Yg/l2nDyWu8Y2qe4tFOBJ6buANBPwF3DuD4lNRU
	6fJ6XfuAQ5hLl2X4Ircuf1keO2yBfuatNKQuc436CSOKUFVpmFq9I/IDRBpdcrmH9Ntu3F1m5KX
	nvKZ1ocP7rNP80ZDX1rYFs0dWzKLR4Zbs0+qEoYBuxWmAe8MoPhUcCY7wH42B3u4kakZzPczdCH
	/U5TvagGHSHzvGNRLzVpxFJH5462SujlfGYX449h3ocURv6mlE9REbGldvXMunRj5iY1muk8hLA
	IiTZPhLHaGUKYCndlroK3dNfli4w3Hcq7t4YFy7NLVkCZzOQm38V263CCYLf/CpiRUBLlpMXbew
	znVS87ffhMl3xRnfKZwDfG92uzl/JfryKILR2rHPq7BN1vynB+i22Lj5jbw2+JGRkdyNCp+LJYc
	GRJrAJANJOw3aoeGlZwrSbc05SATREGw/dcx2tICtCy6OAhPdPafTwMu9Gn9tk855+UTBuv4bLw
	uxYksmZZ9B0wXoTCTDgUxlR
X-Received: by 2002:a05:600c:3547:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-48350521bebmr28279235e9.8.1770723292197;
        Tue, 10 Feb 2026 03:34:52 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:51 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 5/5] tracing: Free up file->private_data for use by individual events
Date: Tue, 10 Feb 2026 12:28:20 +0100
Message-ID: <20260210113427.1068932-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210113427.1068932-1-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracing_open_file_tr() function currently copies the trace_event_file
pointer from inode->i_private to file->private_data when the file is
successfully opened. This duplication is not particularly useful, as all
event code should utilize event_file_file() or event_file_data() to
retrieve a trace_event_file pointer from a file struct and these access
functions read file->f_inode->i_private. Moreover, this setup requires the
code for opening hist files to explicitly clear file->private_data before
calling single_open(), since this function expects the private_data member
to be set to NULL and uses it to store a pointer to a seq_file.

Remove the unnecessary setting of file->private_data in
tracing_open_file_tr() and simplify the hist code.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.c             | 2 --
 kernel/trace/trace_events_hist.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..7c9882e5ba22 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4805,8 +4805,6 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 		event_file_get(file);
 	}
 
-	filp->private_data = inode->i_private;
-
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 744c2aa3d668..1ca3e14d7531 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5831,8 +5831,6 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	hist_file->file = file;
 	hist_file->last_act = get_hist_hit_count(event_file);
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
 	if (ret) {
 		kfree(hist_file);
@@ -6114,8 +6112,6 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_debug_show, file);
 	if (ret)
 		tracing_release_file_tr(inode, file);
-- 
2.52.0

