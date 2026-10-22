Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646276;
	b=qmWcV199tG2BIcjJ5w7+IG3IOu4MpBrcBf2kl6m7HHIzQkaOEhAE7v27gGRvxeX6I6bK
	 whorAPbNkNx4Pv9BaqDPWlCMOU5oDhUWe/1NZlzq89Vehzn08E1jpK9Rj67pksAOU0A9R
	 z37eJtoh537n8HsLoY/5eArYmG4h22FeEetpxsW/XSbvQJTRamgVbL9JEFncPbFGhhtSi
	 32y1KOKOfbwFLx5iE2TA7iJmpW8UfQTDqMi3FlcXtb/fDln50NranWO2vLuT/50qr8pXu
	 aOwY7puI9WAMvQbCo0kNkBzquzfuZdM8b9ShO24/SFMFuaN9E4ZDeWosJ3tjYOSvqRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
	b=00DgLGurp4TWSyb1m6ZG+uHtr3hh6C7gB+NgHjcnLKhT5AEjks5Mqn5zaf/HSI3/HdvZ
	 Qj3m3e3/EecjzQkPnkEa7dGNCoXC25J8iwhuOttDvM4OzxxvtBegL6AYYgY7fYULbXZeY
	 gMahRtliw6oy3v7uVR+xvNFxwtLaDzMEUSTqAhXt7bVrZq2lX1INeWTFsXFB0tp4f9tz6
	 zqqgwBJAPnlY6qZ+FZRTuSeoy5JnWrDBqVbEWhKGupBeTl8qnU/hW8xD59OO/5A4YwyYn
	 0XtJJqzPrv4i6LQYhS5Zf4QM4dHQ92RSc6pSjC3dpRD/ZnBPwMV2MDzWxtzJsaC6qZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PrEznyt3;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E960A2614
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66E960A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PrEznyt3
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20568c8c0so2397275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646274; x=1793251074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
        b=PrEznyt3V0Td5d9mPQAr6GTSP8KU/wwhLLQOftyeTLWqx9zUFisZ+lIkfVCM/A68nJ
         j9v1XOQuZeLHYD3KRntWHTA4EyohSUpujaqZKhQCzmD+PucpLXzrsFhAnvayYWoy/PRO
         /ShIPkXt6F+g/JfZNNmweaTq+DTNmB/MxjZUH57bA6hQY/ah4jJQsc4XNYgVKBjR5+Eo
         qxTiqhD+C+7fFnA06O4Oxlzp67o5bk9MP9UI0T6QZ+ZV2VvRlocC/sbwWDR14bCETXQd
         XnggQdCI0wcO6hAin7ygVQmG5i+DrLXDbGrHiruPWt0Pxs7jAcLonBHV0wLuMaVtmp4M
         v+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646274; x=1793251074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mo4ijoE4/zyX2xv2dQEbhTN41cna2GSZkZljd09Fpk4=;
        b=260dVb+mxJ19pYdwfYIfzLo3RTjXIf/dDVegQx9qaeW8nk3XFrCCOKWTr+UdJR7vM8
         hPR6QGRMrK2KyvVqVL5EYFqgfZ/DLLHFy/6+8CsmrPsRkEiwNzl8Wc1qIjkiCm28x7Vm
         3gbkNFXMC0IdQjq302jaB3HWICuPHi6mCBYXJ1BI9naesTQycns39WONTKXzRLbYZK5T
         ALnykBu6PTyc9tT83qbR6lWDu6ZzMp2alj+yp2lo7H73ruPjKpwuyWn4ox5qC692C09E
         D8eCIfUvakLgbn0UEBiTtXk1tFTh+kye39eBOUd8XHly52P2y1S3qceGnMyFt6S/2Hvl
         aLWg==
X-Forwarded-Encrypted: i=1; AKwUvByrYN4PhEQV5dG9R9eOLrWYUQgKjD1/dfBlDuvpicBS9WA+6GsrYa4AdN6ZLC6DgEgk9T8GX7argSPj9Zqjq7Z22Qs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4EV3zz1+zfe5DF1VTI8bzqsahs7/HYLUnao7KipJa5kifZFqs
	TjOaNgTJAjRWyhlxdgThJzRHijR+UuyZ0+VGtgG/1DMezT/mY0s1Cf9w
X-Gm-Gg: AYBFou222am1DSAyQoS9GEd4Ok13lzS1nGxbxq5xVJpE2m4Nppc3LjagXW4i3IFOFlo
	4erbgn+SKSNU5vMzOfIUPNCePh7lIk+x4ASXLIV8I48RUXX2qMkxHNtDjr1jG7w95e5vFpYrsJW
	dMvMc7i25e7/S+fXTNYw+JwpmwFfyZa/msoAtBgwXVJR8rWXpb51f9jCBQ0870J2eXEq3DEErGb
	WVbP6NHQwe04Br8krEcr13iAmthOX6uC5C8a3fmpFUDnUCRRU2n79Vno6mK5d9K7ceFPMxcXlyR
	ro8Ddan4GKWMxKSIV69pxMH1Us7p8y64Oit9kubFOiZpk7fJb8Wo48psSerWi0KeiSvTR5XC0PP
	IaD5chOPSnEhpzeOi2RkLV4vVnb0Wus+9k9Ek8XzAUDnO9orRaW42Q+QDcvPj46t4luccwVYWey
	3HDT4joQJSIh98f6692+uKe8QUeKFW/2rbNP6aQGN0tz3Wpu8M+ZNNSdThNMEf6vKp15fitsWnl
	ll16BYAzTdQcEW/F4lUXl82TNoQTPAhSvmB1EIw7ezFq+YDojrB+5dWWX+usnfczPJpNax16BYm
	4wk1VbKXUDAYdF8h0wUmFsW3dQKKa5wJl0v+URb0w0VBMBa+X5g6hn/4Q9mxGh7oM3ASyB2hdmH
	+a93o0I8sIW9fD72bSZagxSjA/HDhyO/rD2dOQYDLAwpZXyM4mNCkh4YaFcFQ
X-Received: by 2002:a05:600c:1c09:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4a1fdd2468bmr84667645e9.7.1792646274255;
        Wed, 21 Oct 2026 22:17:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/12] tracing: Pin recursion state for its complete lifetime
Date: Thu, 22 Oct 2026 07:16:54 +0200
Message-Id: <20261022051654.79224-13-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_test_and_set_recursion() publishes the task recursion bit before it
disables preemption. Scheduler tracing can therefore run while acquisition
is in progress. Conversely, trace_clear_recursion() enables preemption
before clearing the bit, so a reschedule can observe stale recursion state
during release.

CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING also validates RCU state before the
outer preemption disable. rcu_is_watching() drops its internal preemption
reference before returning, and the warning path accesses
TRACE_RECORD_RECURSION_BIT outside the protected lifetime.

Disable preemption before validation and retain that reference until the
recursion bit is cleared. Balance both rejection paths. This keeps
validation and published recursion state inside one preemption-disabled
interval.

Keep the transition slot unchanged. It remains necessary for
interrupt-entry intervals whose context is not yet reflected in
preempt_count().

Use preempt_enable_notrace() because this inline API is also used by
modules. The no-reschedule variant is unavailable there.

Assisted-by: LLM
---
 include/linux/trace_recursion.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index e6ca052b2a85a..fd14380751404 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -126,11 +126,16 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start)
 {
-	unsigned int val = READ_ONCE(current->trace_recursion);
+	unsigned int val;
 	int bit;
 
-	if (trace_warn_on_no_rcu(ip))
+	preempt_disable_notrace();
+	if (trace_warn_on_no_rcu(ip)) {
+		preempt_enable_notrace();
 		return -1;
+	}
+
+	val = READ_ONCE(current->trace_recursion);
 
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
@@ -145,6 +150,7 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		bit = TRACE_CTX_TRANSITION + start;
 		if (val & (1 << bit)) {
 			do_ftrace_record_recursion(ip, pip);
+			preempt_enable_notrace();
 			return -1;
 		}
 	}
@@ -153,8 +159,6 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	current->trace_recursion = val;
 	barrier();
 
-	preempt_disable_notrace();
-
 	return bit;
 }
 
@@ -163,9 +167,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
  */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
+	preempt_enable_notrace();
 }
 
 /**
-- 
2.39.5 (Apple Git-154)

