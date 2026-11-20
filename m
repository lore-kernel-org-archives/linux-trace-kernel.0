Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136921;
	b=eiGedZ69crj2CSCpTmTUJeqYoRuunGVcXCaplF0PgXAaEUYw9mtmLdmROA1m5srFYY5j
	 Wop2LnsYc1MCbu/okdRA3Xb/f83C7oD334OYx7S9u8utVEBvZjpy/d8MZbVloo/nFh2wL
	 G26hWGOdbMA/2sCpAgW8uR5zzMW67/CLw+OVkAgairXv/q362PjVMtyCQs7XI47nRmA/E
	 6VQiFMxFWCj2Ua4OHOxJmArbhIRJjafU2P3Dlxrk9fW/LIUIsFXb1cxsNkCt2hKqAy41k
	 Y+qVure9ols2idexKL7t+wzRUeNISaI9Km1EYvJlY1rQsh/VqRl0YKC1C4tTtSwvbNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
	b=w4XsY07V4dRU4hrGemHkwi3uwP6E3+p8Sv966ZHrY2AVcDtEtseedgC0/efVmwKqHfYe
	 MyUbLW7g7S5rY/EG2G3+A4MRVknLj7Gf7K6cp6ATTOn0soXWrT8kOZ/t1eZr/AHVHwfRV
	 rk8ZUSG+mTRloFT6v7/0dYRdoFcEBmu4dDcEl/2LPg2BPiOx7EwL3ydeix3J+XBbRLfy6
	 px/vqVc6Gi6BfO1bwHZY225DJDYC1fbF65d2S2rXBicM9CFWuIxcj9tmlFD841d9fBvky
	 v8yJEw3w24+TaQ8xAhxLX+1GikbaGF2dZFOfSl3LLL6+HoVpNjEAaCOWYLk/mBUjP+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2tPubG;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58B606A325
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 01:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A58B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2tPubG
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso2197395ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 17:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795136920; x=1795741720; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
        b=zv2tPubGZQUVZlU14gcYvRYJFSgkeZOX5Ccg9jvkxVA+wHGnL5K9L6LPNWGK3z31aj
         MkaN8o1K1Vwu+xxlxTX9MQjCYrrHhLE+kicoZ9ZBU6ecc9JZTetAryyshiDIVD4MAlaM
         t9vPKuEaPoTkKDrzYobbWP634m61ZuUXCMHJJTeBqIYQJ1Aek8/eyPayQsqcCSCPs+GA
         BxIC072hizkK9xT75+USvmVvNcddyJXFy2wkfgtT/uxfef1enXRunV4N+tgd8psd0B9h
         Ot1W1bFzhuqs4RjSaQ5aDcxBBWzsstK/A6wDjmBCGlN98NS9XmD5+4IGdxtsdgHqIgMC
         odug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136920; x=1795741720;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
        b=DPTeuQ9LZ/gp2eFhvjGh5+SIOBILigYuofSpKdlbzF8qLZftYLgbwYPalWR5eVAoKG
         V+Rvf7zRMftAinNr+pE5JK3+N9e+xKsTJgh+kezkDzQHYvdqYgjZtYv4gG7VtbGH5Ifn
         H37PCe/eTUmp3lL7y0tIZtrd4g1Y1T/93T1jgq0z/WOlO6emfmsQsdVqhVBrftG9YQU+
         TsjiM2nFcGd4kkOOQO7+c+XMyM4HWgBZtRTjt/I6Uwsms80YP+s6QwWTCzxfw7XZ+fop
         1kRTL6mI7mOtCcrv9Sh+1Dc5A/raSTcsX+YPpwbEnw9e7/cOcvJ7CXaHxnAyWcnCwBip
         s9rQ==
X-Forwarded-Encrypted: i=1; AL+hErHkOX7A4sZowpzNF/FgHWw2wH2XtN+n6/x7/45HdmMWgeQLD4yJnFtFW2iHmcxXfZmHClneoZJZN8S0bU/8rzEABjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WwMHGmr68CVT75b5tH7L1kz72tmw8V4syosUf+v3sShr/GwYU
	/r0ZEsGI6mctWQAILOEnS7A8sfCr4lH6xETaNKUUAkfWVDJfQokrU8ME
X-Gm-Gg: AZFdTZeqnIi4ZRYMRkr4961U/WD/LcSSCj6hSjIDFlzlzcDaqKadqvxL15bMkdnxIEn
	EAhDGByyS48fvHTlWjPGm5JTuTK5AObUVFKCR8XW7k4I4TpTlf3pHflkRZvG938OKMMlwq9n13j
	nMkpRW5Zl8XkU5c1EzKIUN9WAx/N39CAl922FaHFf3M0QfMqiOM/hRK9lWJMb5z4TB1gjy2TXMh
	lOc1QAoh4NoO3gBXAeEO4Ish5PdNbnSSVvWhl2z/NaUVf1VuwxypLBuB50TwFwPj6C6ioy+OG7g
	GE+79MMH0BLC2AfZxoZviGbJKh9tyhGqhLXbHdSmdn55p5fYYJU9ln813fxlpxemRlrLdcGv2gO
	2wWjhk4T0nxxH/C3lhu4CQqltHSK7TZOySgqF2lbE6iLX5iDgep42d+5lP8/wjopgEE0OOvFoPZ
	rnER4/7B6ajFmtHHs1yeI8qiFj97MaEIunVEU6qPPkphTIscBAeVyYty2zozr1Ly4Qqm3A12Ztm
	HD4fd8rov8ChyYxqVTPv3cs6UydIH+G8jrOFAuWUCmO5I8Mfm2PQxWheX3/2bPmsf06Yu73PDeR
	lvyqUQjNpk1znMnRU5AWXnwDZ6grsMNNuO3tcgIgqp4hJk3pUNqzAaNURZ6oKDesOmuFFboBXBY
	wpXFsA3MBCMgVvIHHzfN4eYf75qywH1jHtQ==
X-Received: by 2002:a17:903:2441:b0:2f0:3d6d:a089 with SMTP id d9443c01a7336-2f03ef870d3mr15115475ad.1.1795136919620;
        Thu, 19 Nov 2026 17:08:39 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ea6a8sm6302305ad.36.2026.11.19.17.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 17:08:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 01:08:38 +0000
Message-Id: <DMZMXFOOKT03.2D4M33BG6WTRP@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mike.bazov@gmail.com>, "Mike Bazov via B4 Relay"
 <devnull+mike.bazov.gmail.com@kernel.org>, "Song Liu" <song@kernel.org>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "KP Singh" <kpsingh@kernel.org>, "Matt
 Bobrowski" <matt@bobrowski.net>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
References: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 02:37 AM Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org> wrote:
> Each caller then has its own registers, however it nests or gets
> preempted, and the helpers no longer fail with -EBUSY when nested more
> than three deep.

bpf-ci is correct.
let's remove that warn_on as part of the series.

we have another hole:

  prog 1 on mmap_lock_acquire_returned
    bpf_get_stack(BPF_F_USER_STACK | BPF_F_USER_BUILD_ID)
      mmap_read_trylock()
        prog 2 on mmap_lock_acquire_returned

stack colection with build_id's will disappear.

Let's fix all together with somethign like:

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 1834db2..65673d1 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -13,6 +13,7 @@ struct mmap_unlock_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
 	atomic_t active;
+	int nest_level;
 };
 
 DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
@@ -28,8 +29,13 @@ static inline struct mmap_unlock_irq_work *bpf_mmap_unlock_guard_get(void)
 {
 	struct mmap_unlock_irq_work *work;
 
-	if (!irqs_disabled())
-		return NULL;
+	if (!irqs_disabled()) {
+		/* progs on mmap_lock tracepoints can get here again */
+		if (this_cpu_inc_return(mmap_unlock_work.nest_level) <= 3)
+			return NULL;
+		this_cpu_dec(mmap_unlock_work.nest_level);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * PREEMPT_RT does not allow to trylock mmap sem in interrupt
@@ -51,12 +57,15 @@ bpf_mmap_unlock_guard_put(struct mmap_unlock_irq_work *work)
 {
 	if (work)
 		atomic_set_release(&work->active, 0);
+	else
+		this_cpu_dec(mmap_unlock_work.nest_level);
 }
 
 static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
 {
 	if (!work) {
 		mmap_read_unlock(mm);
+		bpf_mmap_unlock_guard_put(NULL);
 	} else {
 		work->mm = mm;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3f1901a..5c49c13 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -702,7 +702,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	sds = this_cpu_ptr(&bpf_trace_sds);
 	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
+	if (nest_level > ARRAY_SIZE(sds->sds)) {
 		err = -EBUSY;
 		goto out;
 	}

pw-bot: cr
