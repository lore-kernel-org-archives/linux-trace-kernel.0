Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11731AAAF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Feb 2026 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578548; cv=none; b=pHbj9QG6O5iHkamllvSUvTtkuCZZrqGnqQiQXTIS5wjeq4xMKZyC7XDx1HFnvmkgMOLLzXwHWoUWCZPrmfu/sGPMGAE86UWjo7E9sx0+JosPiwNr6oO2ox0R2P8VnMhGCKHFTETFOTAPWgzwHlCxua+qxPVbw7tWXEwLjNoH0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578548; c=relaxed/simple;
	bh=W/uz2T87r9U3hpaetbdjaYKd/rLTOIiMqSbbCdADBng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcI8fmglSpBsgvnQtR7sWInIw6ayYYoAxlgG5+SXPyIn9xUQefaBEJRiKlphEVVrOGq9DruIFyksXkvXAgLascCRxENXIw6Yv/JfVwvDGjCOyb4EWPhpK5U1bAe7d9l9cs2nHtBwO1vevQ1sRN/8dycUkca4hhmPuvtmPoEGfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKgbwYs7; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKgbwYs7"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a76b39587aso73385ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Feb 2026 01:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771578546; x=1772183346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7F8WxQjk8Orm8VMuPYwxSvcxytWiyPGbiUS8y914NAU=;
        b=hKgbwYs7MM+uFJzdVuXDs+POHN2edZJITtcmrLqYrhASgH55zat3aLJSefUn+b8flK
         MNWVDa1KwjMkksq6G+AAaq5a+cprpu/SbikcPajEo4UybAtNNtsaSQnpW2QIXgdGOsEA
         +fsqNj62tUUlQ8PVOM8w+eBP9DNEuuu8TEkJi53QPVCYKx7oozRQPp1NNMvJ497gurs8
         Rm+00NX5CG2G/EyPj+PdFV65YHF0FV54H/33pyi/5faYD6UaTUmv6SgwFWX4DGOEBQCx
         K7SeGU73qO8DQEDHs3SOX47cacY4zDzXgHLDYbsbW/+ko6il4FBQ0wIWiu7hcpqCSM0T
         1Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771578546; x=1772183346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F8WxQjk8Orm8VMuPYwxSvcxytWiyPGbiUS8y914NAU=;
        b=KfuZzD42ArseMjhbj6wVheaU7shQVy0eg1LgIYEnMlUliyV4AbgDp59ZxAxxK20RL7
         G6dDZLFxilLYiJ+EtmHoimoN3VgILa8PVofKQsbNmUp+YOuXTq8OZyOABVRPc0daufrC
         bBDtGjklbW4jQCnztPqMz/wL5otgqsaVD9SPqW9a12Jck/WFpKXXzNQo94w5P96y49Iq
         Ra7j2siILEHq+TRo9vzns5iiQwh9wSiada0aRfJy0rSxeyy71kzi+Bz/C9P5ixcDbD8f
         sx4HoaZn6c/1vrD/fIigvZgtgN1uqrPAmtbahg8rP4vPywCjJyziKV5b+O5z98zd9AfI
         tdyA==
X-Forwarded-Encrypted: i=1; AJvYcCVj1m4pc2VOB3DVmsno44nluKIvhUtnBaC7Ldr/l9bdFC9LCknSyVpJE0TONQ1yTWNoa06qaWEB7GTtNwuyUtECYCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmFaAZtezvZgjoZeDTVGx6t3++iNKmNso7knXuIlGNSxq2YrP
	UpJsU8I0mibWkz4ic4kowO5ZHLmHSsyyOKgp1Aq8qfW0f17Epj2WrJEdROXxoaSerw==
X-Gm-Gg: AZuq6aLvx/6TJIu2UJ8XDxTcLX0XfCWuDgC2KUKbZoUCXrjZX8oeDy1r02pmuLEcNVA
	GEgVW02a9eXQ32isAummTESJFQZmSbiHwvA5z0il+z4DDk5ybCeASY2cIWFD7wX0MkApFoOQheF
	lL7nyAM9UMOvl12GK9w3feklV8D9OXTNllxyTqOuJLOdnIJdu6u9Vg7zyElvTCRbcqG9QEiUCkr
	2gn9LIhTsbzuesS1GY81Aw3Z1fTGu34AhDFgmAvso0b0vS1CAX9p2xjWg9vHzu59IrR4/mPco5m
	tRR/jGZn3L711R7MqCtrQm+jhvY1/t2FxwgY12aVMBKeh9eEA6Ra8x3E2mZfsG/8xNyQHsycB75
	Dq5xTz1sKeZFLFyYPOQrlQjcvRGvG7MQJ308B6sbuqtxVv/blYsRUC4OaLhPARXAIWx5xNWGqNH
	SrpNvjNib6jJmNms4wytDw9hKP9POntS0W0GSEHMTSKZKIdK2aqoHyHL/z6TE=
X-Received: by 2002:a17:902:d584:b0:294:d42c:ca0f with SMTP id d9443c01a7336-2ad69e114ddmr1743575ad.2.1771578545548;
        Fri, 20 Feb 2026 01:09:05 -0800 (PST)
Received: from google.com (249.53.168.34.bc.googleusercontent.com. [34.168.53.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a3e145sm20081108b3a.16.2026.02.20.01.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:09:04 -0800 (PST)
Date: Fri, 20 Feb 2026 09:09:00 +0000
From: Lisa Wang <wyihan@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com,
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com,
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com,
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com,
	jroedel@suse.de, jthoughton@google.com, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	michael.roth@amd.com, mingo@redhat.com, mlevitsk@redhat.com,
	oupton@kernel.org, pankaj.gupta@amd.com, pbonzini@redhat.com,
	prsampat@amd.com, qperret@google.com, ricarkol@google.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com,
	shuah@kernel.org, steven.price@arm.com, tabba@google.com,
	tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz,
	willy@infradead.org, yan.y.zhao@intel.com
Subject: Re: [RFC PATCH v2 00/37] guest_memfd: In-place conversion support
Message-ID: <aZgkrJv3FeQCZ2DG@google.com>
References: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>

On Mon, Feb 02, 2026 at 02:36:37PM -0800, Ackerley Tng wrote:
> (resending to fix Message-ID)
> 
> Here's a second revision of guest_memfd In-place conversion support.
> 
> In this version, other than addressing comments from RFCv1 [1], the largest
> change is that guest_memfd now does not avoid participation in LRU; it
> participates in LRU by joining the unevictable list (no change from before this
> series).
> 
> While checking for elevated refcounts during shared to private conversions,
> guest_memfd will now do an lru_add_drain_all() if elevated refcounts were found,
> before concluding that there are true users of the shared folio and erroring
> out.
> 
> I'd still like feedback on these points, if any:
> 
> 1. Having private/shared status stored in a maple tree (Thanks Michael for your
>    support of using maple trees over xarrays for performance! [5]).
> 2. Having a new guest_memfd ioctl (not a vm ioctl) that performs conversions.
> 3. Using ioctls/structs/input attribute similar to the existing vm ioctl
>    KVM_SET_MEMORY_ATTRIBUTES to perform conversions.
> 4. Storing requested attributes directly in the maple tree.
> 5. Using a KVM module-wide param to toggle between setting memory attributes via
>    vm and guest_memfd ioctls (making them mututally exclusive - a single loaded
>    KVM module can only do one of the two.).
> 
> [...snip...]
>
> 
> --
> 2.53.0.rc1.225.gd81095ad13-goog

I’ve tested memory failure handling after applying this series and here’s what
memory_failure() does:

Shared memory: In line with other in-memory filesystems, the memory_failure()
handler unmaps the page if it is currently mapped, and issues a SIGBUS
  - if memory failure was injected with MF_ACTION_REQUIRED or
  - if the test process’s memory corruption kill policy is PR_MCE_KILL_EARLY

Here’s the above, in table form:

| MF_ACTION_REQUIRED | Kill Policy         | Mapped | Dirty | Result: SIGBUS |
|--------------------|---------------------|--------|-------|----------------|
| false              | PR_MCE_KILL_EARLY   | true   | true  | true           |
| false              | PR_MCE_KILL_EARLY   | true   | false | false          |
| false              | PR_MCE_KILL_EARLY   | false  | true  | false          |
| false              | PR_MCE_KILL_EARLY   | false  | false | false          |
| false              | PR_MCE_KILL_LATE    | true   | true  | false          |
| false              | PR_MCE_KILL_LATE    | true   | false | false          |
| false              | PR_MCE_KILL_LATE    | false  | true  | false          |
| false              | PR_MCE_KILL_LATE    | false  | false | false          |
| true               | Any Policy          | true   | true  | true           |
| true               | Any Policy          | true   | false | false          |

(I used MADV_HWPOISON to inject memory failures with MF_ACTION_REQUIRED set, and
there was no way to use MADV_HWPOISON without first mapping the page in. To
inject memory failures without MF_ACTION_REQUIRED set, I used debugfs’
hwpoison/corrupt-pfn.)

Private memory: The handler unmaps the page for the stage 2 page table and does
not issue a SIGBUS - the page is never mapped to the host, since it is private
to the guest.

| MF_ACTION_REQUIRED | Kill Policy         | Mapped | Dirty | Result: SIGBUS |
|--------------------|---------------------|--------|-------|----------------|
| false              | PR_MCE_KILL_EARLY   | false  | true  | false          |
| false              | PR_MCE_KILL_EARLY   | false  | false | false          |
| false              | PR_MCE_KILL_LATE    | false  | true  | false          |
| false              | PR_MCE_KILL_LATE    | false  | false | false          |

(I couldn’t use MADV_HWPOISON since private memory could not be mapped and hence
will not have a userspace address)

I’ll post updated memory failure tests together with the next revision of this
series [1] to fix MF_DELAYED handling on memory failure.

[1] https://lore.kernel.org/all/cover.1760551864.git.wyihan@google.com/T/

