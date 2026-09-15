Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA2207A20
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457043; cv=none; b=fYitCd281bQvfrcmO63ftkcZKkWXkD+yX43CEi6h7xmidyc1+EITEmaoAdQa/QPegXQYTpuPLwx58tC77yZQsrH9nOXxwEiWj8x5DB3IMOTcLFMO0XfXZYVEPR2SXEZgSQvjtjQVUPLDqVBlKM8u25gpwJKOwYLYuQOqzYTzcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457043; c=relaxed/simple;
	bh=AFY3lN0nPpdQzHz01v1mY6oxQ6Y3SsL8Xqae2tfNAfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9RLs4nbPfDjo3fAURFk7JIl0xSDQ4P05kKQR81dMgC7PFAJMvhOr+1zo3rN/L726dOKMBUvg1xbs4jikVwllhB8j7DHk/wIsxYMdj4cv82Pw8OpnMRXULHn63+CByTJIYlWChCpPGy/jQ6wB4cKrCRMgYdr54Xk3oR4UToayCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kohRUwf4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kohRUwf4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so11647755e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789457039; x=1790061839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3byU7IfKsmqkwQHBDdGKLnfWdbNnlxn1U1wY0CrzBZc=;
        b=kohRUwf42q58l3LOwCyUoujPif/jPGfLDXZiu/W+Spd+D4YG3HA+wfKN0cCbrb2hZ9
         l1aeg0lnWE0IwoKYyISxHoWVOhHTXoQ0VuXW+eQCNWZYo+WZtpjBXITO92VgVNyRP5x6
         ZsUAo4yP9ypAgcRphvB6H9SoCO4lj3fYhpsZ57pshht6428MjHMDX19S7+yFssmo7mTJ
         yD83n6PEC+sQY1Uq1QR964ecr8wVSj3XdSf3MhpBRQ/JMcF42G0cOSdHAQ3VBskhj3ic
         /chiz0vupX/QUJYSMFizeXD1kAc2wede0GpsNbPTNEVm2oW6o9Zc7C9SutCJyY58Iwpp
         MxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789457039; x=1790061839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3byU7IfKsmqkwQHBDdGKLnfWdbNnlxn1U1wY0CrzBZc=;
        b=SbEJjH/hIcdBT5nFLiwyFVelSz4bNljzN/GAtRhmIv04CDEPNKGsH6Dbz8yUT1BU5d
         lTxIxEphQ07a95RV/bFQdbtmgURm2Ck1hEupikqPbU6QWEtAMvquyRu8qNj+HrKL8GgH
         ApoSLzKf8rDlzSL66/t5Qr0vktKlmqiJGrOB4gBRUH69ou37LScFmJRmY+QR6owIRUXd
         bgmfchFdePJzxGqJL974u7eDEJKjJazU6uotxBqnGSkfuZhVeOEuFCQmexEh/vvS1ADS
         6EEHV9a3r/AxPAgLWKcqyh5n4kK2mtH7jwIShx8EUGBQt+otG7lFNJnKZO+n8wgJhtCg
         skjQ==
X-Forwarded-Encrypted: i=1; AKwUvBysr9PRtGn2NqOMQUMqvguiZ+xHNNCaNx3hneChclgQ/ZTO80izpoTmsntCGWgy2El2bsqvfcU0x/ShYegAOEJZpqs=@vger.kernel.org
X-Gm-Message-State: AFuF++lAPFq1p/crUjsqSZwncDI0owY1LYZwHMzdCF3g3U5l53Y11oyB
	TeR5mlOE5Qvo3iki7MGfeOm/cuak51hMEOzXXy538iVkLaR9w9lPTo355+m7lVTWJw==
X-Gm-Gg: AYBFou2y6NlWlN1vx7n5Ideah/NxGC6PF0mqzbvfxuhax/tN5TLW6B39Pu4lcy5llGn
	8fd3nmBaQ7j1MLIN/mEOxzCBhNQ/d8bepqTT3JECeMJV2/hX/umgYB/yBQpTwbXgVMlCM9nyrf0
	fOxgzRp3g+YGucGcAjtdYZf/V3a41Oq/yXwfSdHiPfL/gRBgAJDiWOXiYf9+pRJT2qdX0tpcgCh
	61qxGGTSyeROIv8c7NrzvSakLzmKV0xFwwmIGPmf8pFhecHrer418kCEjobYp9oTeZ4SeRMhqRX
	wiAFaxo41XRNAXp5/vOAf3z5kVX/o0qXGZjbknD5EQ1kZuh4cVWuIo0Q6t6KQFoRux6+Kd+jCSJ
	bQ0aeo6bAXC993DOGaJuCALeXVuCMe1y3DzgQZVrORD2KXt2fVxhl9dtetolYVOdedOIKGztn0t
	VLXgjb0EKPHHcCX8mk25v6Dq9a5ARPtKAOz85CdaP5j4ZFBCIVZ60T+gIqu4FnFoCBPzCwWSMX4
	es6iwPT+aeqV7HGZJDn9FGp+lrVnHiJ+ilSwCMejMUdp3a3LF6Q0A==
X-Received: by 2002:a05:600c:c162:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49e7d72b000mr32527185e9.5.1789457038909;
        Tue, 15 Sep 2026 00:23:58 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a9d1dsm52818775e9.10.2026.09.15.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:23:58 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:23:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David CARLIER <devnexen@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ring-buffer: Clean up resize_disabled checks
Message-ID: <aqjyi2RD4oSCAY7z@google.com>
References: <20260914175907.1027349-1-vdonnefort@google.com>
 <CA+XhMqxp2XOB9PnfHJwBvK0up8Oej4hGcnsM0a=fdoRDyVoEyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqxp2XOB9PnfHJwBvK0up8Oej4hGcnsM0a=fdoRDyVoEyQ@mail.gmail.com>

On Mon, Sep 14, 2026 at 08:09:24PM +0100, David CARLIER wrote:
> Hi Vincent.
> 
> > +   if (rb_resize_disabled(buffer, cpu_id)) {
> > +           err = -EBUSY;
> > +           goto out_err_unlock;
> > +   }
> 
> For a single CPU, this now happens before the nr_pages == cpu_buffer->nr_pages
> early exit, so writing the same size to per_cpu/cpuN/buffer_size_kb on a
> mapped or persistent instance CPU fails with EBUSY instead of succeeding.
> Intended ?

Actually no, I didn't see that it is also "fixing" this discrepancy between the
per_cpu buffer_size_kb and the global one.

It seems to me better to align the behaviour for both interface, but then it is
touching something that is user interface... 

Steven, WDYS?

> 
> > Additionally, remove the unnecessary cpumask_test_cpu in
> > ring_buffer_subbuf_order_set().
> 
> The install loop still has one.
> 
> Otherwise removing the second check is fine, the hotplug window is
> covered by the cpus_read_lock() patch I sent separately.
> 
> Cheers.

-- 
Vincent
