Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD422EE4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568044; cv=none; b=tL6FGn4jOUGXQyYqrlVM8IYtvChkM0G/dAxTZNfGfxnDjMgKeDGPoPLtXKnCFW/+PhkWsVNQ31/0kGIAhWK9o/rwG60yApcXIbFx4vTRwNfpwRX/mRvSzY4oPKCcK6OXQfOZDntUWqxLNaPn9+HNOYVlcwCluNRQJdmNy9Z2D2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568044; c=relaxed/simple;
	bh=gNukGFOQEvF3RMbXLA/FmYPjLOTe7W5SSESuvAk89dQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y1q7f62Ze/O4zYmowNHrd3QR0Ftwp1nV9sw5d96a0UNRvslDvY1hynu9NJ3nz+oH6vCZqAuL5Gvb9ZOj3rLAVzvoJiy9n+fBrm+9jn0FmH8g1jiKtM9qOxPwZT5vd+2w+ovEKt4Vf9xMPaNqUPOc9L2ObJmEl0UXMVPBJWr3DuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvyM7dt2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvyM7dt2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2242aca53efso161345ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568041; x=1742172841; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aFGI7k9fvuEWSz7M+B4jyDl0IdV3U4f+IuWu0MGYns=;
        b=pvyM7dt2SSI9gCJjtqXv6GpcMpQyQbnf/13SVDA3IZQpvAIc34zzeR0A6BynCgv+3h
         LV2raS0qXvRy0Efi8B8gVE3vY8coeptvXuUJ/XzcYPN5wpku/sSfh2DEVIZZ4DJ3FCHZ
         EMwvE8HSjRktQHRinH2jm7YkWqVbmq2Yny3PxVieDjGxTzYOH26ibAzkMJXnkx1ZAafy
         UsolMxgZ8jSMSUq5HDAu7LZTgnTO4Gwxos7TZr36v1OnkS2r9queqiXXTID9GMua4m+x
         jH+2/sKnpDnLRknzOq7oVMlShZzSJanP732wCUaB5F1oLfEsb5D8ltAbLaONplt/egRe
         HGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568041; x=1742172841;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aFGI7k9fvuEWSz7M+B4jyDl0IdV3U4f+IuWu0MGYns=;
        b=qVbuyeda9waBZVyxX7ddkN0YuOK0o+AKmMmudle7pwtBORSBvVj8JtV0VF/cTjpH8T
         UWSv6ZahJdA8ezvMRL1JaKVT+RmNKF4HrFZFwLQtbhdjMgQRRaDhtLzxvGZxSYLOuRy/
         TRj4fVBlc6qfM9JL04LCOyoXq+51dczV+6GpkTvFA1I7saalbtX3FT1Tnpo3GSP/8nqz
         RZa+z/mM846oX5x/R6j8NBF2N2KzYLOHkE06nPGbxXmm9FTeMk5BmPQE9gTUuW0tCPUV
         GoJg8v/1BdobPYQ3AXrGNf11MxxYGQHRlMy2GdSSDhor12qh9uKQXOm4Idq4rkq6b6I4
         2meg==
X-Forwarded-Encrypted: i=1; AJvYcCV7PTImnyNgph1yR6tPukT2fVvLCpy3WFsoqhd5Ava7GppOykibtYBCT3+F+PbtwuUDhYSB1rORKaSMBngm6pqr+Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrx1nuFQFquZgfUA1VVBfXiQ9N6luEOYn9joYgF2njvwkiGqs
	E7xJZLNnP34tRoou9XEuH61aO0znhH8wxruLurXoTmB5ceVR5e30W0I1+wrhzw==
X-Gm-Gg: ASbGncshcYfHpbHAgKC2wogr/gyDae5YuTtBnSNnYKhPgTh7lvL57ceEJmyv5IYTCcP
	adlq0eLxVVHP/Xq5s/BAXbBnKSNnUVTpo+4VxntZWoazyq1iHL6bFy+X95Ifp7DRCGk8DKDx0sJ
	O2M3XcZbowC6s0GWcUioe4tkOehsWTzFi2/2UGRtqrvgebTrBFB6IVhoql7Sdb+1pTiTnTWvL55
	r/DDxBGIOVZNSHR5WSPxOhdYOIyMlfY3h7aAvYX1UkwmP+9n23QxECW6al4NYzY/JbhsUJJWQtx
	cRPMP2rC4zYLDtgxItMP3hyHtrjxlXsPXcaqa5R9rGtrDnldOyKfpmDMthLme9x240JsV1Rizsy
	vTqZdgpcCjlSPuQ2wZQcisTD9F6BBwmmMCuxFCqw=
X-Google-Smtp-Source: AGHT+IFA4jjQFXwsUFKTNgFJ6BtN2sXHBnTFAjW1MW82CdCiNN1rvYnOpZq7fII08zyQTfPKCm96hA==
X-Received: by 2002:a17:902:d4c6:b0:215:aca2:dc04 with SMTP id d9443c01a7336-225416ae5famr2687805ad.26.1741568040939;
        Sun, 09 Mar 2025 17:54:00 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c7ac6e11sm2487943b3a.148.2025.03.09.17.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:54:00 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:53:59 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/page_alloc: Add trace event for per-zone lowmem
 reserve setup
In-Reply-To: <20250308034606.2036033-3-liumartin@google.com>
Message-ID: <611025a1-d6aa-57a9-5848-73874eee0dba@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-3-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces the `mm_setup_per_zone_lowmem_reserve` trace
> event,which provides detailed insights into the kernel's per-zone lowmem
> reserve configuration.
> 
> The trace event provides precise timestamps, allowing developers to
> 
> 1. Correlate lowmem reserve changes with specific kernel events and
> able to diagnose unexpected kswapd or direct reclaim behavior
> triggered by dynamic changes in lowmem reserve.
> 
> 2. know memory allocation failures that occur due to insufficient lowmem
> reserve, by precisely correlating allocation attempts with reserve
> adjustments.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>
