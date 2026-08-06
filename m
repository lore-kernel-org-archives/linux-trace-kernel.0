Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CA3876A7
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992843; cv=none; b=Z3Gna9DFOrsHB5N+R+TrrJISFDgwyhbJUKP0wlwNUYl+NmPL2wMNnnQCq7zg9yNYixXrZ2zK7JQEqTqp3fkXCG/K+2Y2yF8Y4WUFV43ZHrZOkdyn96kv2/lycAA3dbfC2lYWYj08pCAM4/0kTzFKSkShw6qTg856uirSilxk+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992843; c=relaxed/simple;
	bh=YySJq6hHiRI5ruUBjw9xY9PfrGu76MSyIUcHMeHoEug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDK68R2NT3SjfpwNYiT5yhdbv9Xe86/1GrXHfoiwIQAvaVy6YBuYpgrIvK8Q4aEif8y6vzDqhsRCFXZA6FtQuVPVdjhc7wGtHZhpKzE9eu9N/5E7tuYdHCW2c/IH8FQKf/wyjmXyIs4Jcd9ZpzSwJbNFPTJ06/+BkEgQrGeMqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBrgToE3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBrgToE3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-496b7622a83so14017705e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785992840; x=1786597640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9RiNZzQISUcjwGnzw0LWdiOOvRPI/zRy9W/nyk1gSQ=;
        b=OBrgToE3OgdgfJ+Tq9tGGmQE1Xmxfb3aHGKyhO73+ot8oVKwcNVlzeFquB+yB/Y9/f
         DRpd29DGV1f/tj6ZykqK6ot15yBHtGT5ZKDk88OwbbrU4i73FOSegW4Ff91GxujUqyQv
         U/VRdSsCQPM0CvsoPLE9zKgxbLZViHhU53kz4taQV4dgRzW96lZKJkqAOVgAiaaVoCfS
         ThdUKKBMLRwniKB/RkYDq/P795XOmdlnVlSUivvz6wXn3Q4qD1Auj04ylUx//KzE/TUK
         ukTRyFnlRAgnlYhvF1RZmSYUGxpjFXnURqhVNa+hPHqk7hmAnNMDetrIsZpI8MUQ2M/h
         w/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785992840; x=1786597640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9RiNZzQISUcjwGnzw0LWdiOOvRPI/zRy9W/nyk1gSQ=;
        b=SM9CuQsPccQl448Gy68OJsnM/SgOkydo0U+6N0b3JwcuYRS82ATXPE5Tr1RPuJuYrq
         QbMPXuaIzrOybUB5SxFDwBGaeG8hf6GiLhoPc1sXfO5+Jfvw4PEuC4fdvmssWl+hkQ33
         bkhhd644ts0CdYE+wKJjFJvlNkXgCF57d9fcT0xL1a3zbvkCv619d8deSIDFkpejfJqZ
         mhLTpany9K34YL2sWtZ2KDxiXyYISXcAQMpa+Um/QljnkkCozKm8C0qJCyAXpPLVrk2S
         Or4tj+0QYDpXW9fV1tDl/JdJTM6u1QC0ZvpN34IT+I6zyszay7JRNV/VY2wF1R6eU2nD
         DWSg==
X-Forwarded-Encrypted: i=1; AHgh+RqGUPZRcfwLGfblzEzsKiPjI6JIfflZSwBv4UtgDPePLwgyTa1kke3lH/rh/f1NfeOWMqqTJMOj4RoCdnufIdHyaAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEQYdyuY7mUq+582WWX0TJ/OwvttUyjdPxffzueYHUS7FC6EZ
	jCC/+EETB8AtLrxPLuQG4bXuKVmkiAyT+riYiLInS7rC9CUhyId5mdQ8
X-Gm-Gg: AR+sD12hs7LfLFQ7BE6N8yEopBJEQehWXX19rbAz1Q+KTM44A8cOla+9bqpgIysR+St
	A2oZgKKcjTXSNv3zVzcYlPNRhjhmJBwshf3+Q2+QE9MEdH6QpDEZBgiYmwlp+crXT/L7sj2AbAQ
	daPs+C01iNPGL7RcqFB8exiC7H9J8SlyzfreWBI7CzkGPhrlKf0TJ0/xspENdHMeOyz23G1cQxT
	s122cHHn426KBcUSUddDu6DpYbrtrecQNWrCO6rruK1wpSWI6jMYjI/u3poOrLX0Jkl4SmFF2Nf
	IrlwvDLDF9E9UDRQpzUycq4+ZJG5kVp5psUS1zjHu4SBHfSS+VW3pzGBE6HVsuCjjUXXXKKUIei
	z9zC6Jn67sjbIAj+is/7I7HxVkbh4kOyzWEqnnIywDGdFr9js8bNrZrCGae1OnFnlQ8y8W9Pczn
	CvlBwx1iBiExKcsPdB8BnrnGc+b8YwVzUdRRyrDBrD1rNy4nxqu3HKLio4kypn2iBj4YpKhDrtF
	Wxj1vUoxheinJXTyY2zgJsGZpo8KDC8QqwqGoJsl8esTy4q
X-Received: by 2002:a05:600c:2142:b0:495:5858:8101 with SMTP id 5b1f17b1804b1-4994e7cbcbfmr122212915e9.15.1785992839612;
        Wed, 05 Aug 2026 22:07:19 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420cb4esm32477045e9.2.2026.08.05.22.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:07:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing: Report TP_printk double dereference with pr_warn()
Date: Thu,  6 Aug 2026 06:07:16 +0100
Message-ID: <20260806050716.16612-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_double_dereference() uses WARN_ONCE(), which is per-call-site. Only
the first offending event in the kernel is ever reported, and the tree
still has six: ice_{rx,tx}_dim_template, two hfi1 txq events, mtu3_ep and
edma_log_io. Whichever registers first hides the rest, and it taints the
kernel for what is a source-level mistake.

Use pr_warn() instead, matching the "TRACE EVENT ERROR:" report that
handle_dereference_arg() already emits for the same class of problem.
All offenders are now listed on one boot.

Fixes: b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a8590d2394e3..53f32752edc0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -415,8 +415,8 @@ static void test_double_dereference(const char *str, int len,
 		ptr += 5;
 		for (; ptr < end; ptr++) {
 			if (ptr[0] == '-' && ptr[1] == '>') {
-				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %.*s\n",
-					  trace_event_name(call), len, str);
+				pr_warn("TRACE EVENT ERROR: Event %s has double dereference in TP_printk: %.*s\n",
+					trace_event_name(call), len, str);
 				return;
 			}
 			if (!isalnum(*ptr) && *ptr != '_')
-- 
2.55.0

