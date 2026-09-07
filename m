Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AD175A88
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754809; cv=none; b=cR9i8M6FIk6HvCqau2SAHWy7ZNLLXlUbJdrXmTdzblUybnDKtL705lPHet+hVrx6oWSNXJgM8xRoy/8tdckbpJglV41NrvPfY+o9bzi9f97EJ4QKdtuOKQSfyNjhTc3owC5PMjC+dhnqT57jPVAtIAYRObgdAwoue5XVPri+Xeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754809; c=relaxed/simple;
	bh=13CPypz09GHt9o+0sfOOv9IrECBM665aLcfLRm/+uBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFYJWCAeVbSbJcrf6lYrYMahbgmgxCdjtD1027Y1iiToQz+PFM7ywZEJyPcFCmhYh9nwH747UIxK7iI3X+uIEcSaT3MrBVfmDz2apVwmpuwkMn4TGja85U5ShmJj3RZSMNgHVTl2hTSMNkztnOLnIqZjWeqkw5MNAlCUID1McMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbqOrYNu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbqOrYNu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3570965a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 21:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788754807; x=1789359607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsYcmqAIPiZsMsBOMftJZ1oehq4IFi5iQpNBsUOGPX8=;
        b=kbqOrYNuyk9PXfl7rlyyACUfNGfBzc26BEqCQY+FtDNtAhhQnfj7lMa0WQeDpAxQlU
         rerXL1+SIzVuzT+yiDBYuWGV7UyegJHmB4TWQHG2clqhwmkbYOgdM0vPQu9vhkXdiLlC
         tA54n3RLWkHdS6HMs9d/redtsxFIwr86TI3KUFTOGAY+8ZeTnM+g+kFRpkIlyw4nkbmE
         8vxgOdJBQ1j+A2uz+nty/iKXKBiVFk52DjVLfIhSMvn28ZdQGw/UZX0vFFHynO9vXeiF
         U8o1PcHB2wnAMOYYe8EfZjOL6UCiF1dgMmt34ml9aAvMS7eV64lxbSIlFPfmb2vJLO3J
         lxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788754807; x=1789359607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZsYcmqAIPiZsMsBOMftJZ1oehq4IFi5iQpNBsUOGPX8=;
        b=j6LiQqTwtR8nbJ70zmlj9VaSvDRK0bavLG2CtFjrgc01HZFwNfl84zljDosaGTgWbA
         EtBiXibW5jYYzk0DMyBqIjaXUH441bJkVGk0BdPIyQaclmgJdh1TkXzX7rxv+62nVH8S
         xk5uaseNk3MY2862GJlzoYi5G0/n86aNAQlJUc8nlMiDCAC7f2YT3uUDx377ebKr16OT
         cNrTnuAuLohNRAvHUSfaslf5LfBsWhkI3xT+WRF75QkI9okHTzIyk08fo1dk8Pt70y6l
         cOH8+StZURd5BEt1nQmuDsAr4BQiQCRkilOP/p/Fd379GRZX7Q3fZZkL8ry+VNFx+1Wh
         FepA==
X-Gm-Message-State: AFuF++meyBcTCf1UJLPMo4R9Bs/PocZNzntW0r8VHrg7f40KflCRR2Jr
	/TpiTl0cldpqZ7pxd0QsDQBAHEL8qrW/Vm3Ad7/tDdbsssDr15qiZUA=
X-Gm-Gg: AYBFou0T1hV+2mFqjoPqik4C+vs2bU4KkuMMM1y+qqlOkQriJAFhx6O2dOctSOkIPPF
	InEO1D1FcX8Dr2xXIGhdkZVi+kxbPU5qwrstn2IrXxWwhl1oAayJse1NzygDg9kJOUrHzvR8INR
	73TtdF8oo9XL6qGtdWL3VcbzOqq3fgk87rkXZ3ctOGI8DXNJA3D0JXeFdporDbgYbWznomaA8Di
	VHgOCLEyMQxLL5LCGWoGUW7BDXkSEAZlfeMdH5FHeyITVRLL3DhGteDkOy3MHMr8iySjIxXMoJA
	bIe3mA1bOYaVWUTiqkFP46OL0DOTRB8NStDDNKP4C96clY10rExfC1XGzZaSw9NgT0sIRumkuoC
	qp5xO7i4YCoTsa3ayrDdUZ4D3ipLJ/Vgdw/KBrt8yVTXuy7V7Oul/2h9l5aTEpGmI6dEXDC+/n6
	JSX68/6XJljXayA2AfV2Okn0e/fZaaEmTaqdV+M9orAq8+FG2hAoYfh61wpjGB69Zibc2ibKgGE
	SOClTIpZQBsRiax
X-Received: by 2002:a17:90a:e7c2:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39b261da126mr30116286a91.19.1788754806962;
        Sun, 06 Sep 2026 21:20:06 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm24076502a91.4.2026.09.06.21.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:20:06 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] tracing: hist: free the field rejected for a bad modifier
Date: Mon,  7 Sep 2026 13:20:01 +0900
Message-ID: <20260907042001.263449-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907040425.92BE51F00A3A@smtp.kernel.org>
References: <20260907034948.240387-1-donggeunyoo.kernel@gmail.com> <20260907040425.92BE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 04:04:25AM +0000, sashiko-bot@kernel.org wrote:
> - [High] Preexisting memory leak of VAR_REF hist_field objects when a
> variable is referenced 3 or more times.
> - [High] Preexisting memory leak of VAR_REF hist_field in create_var_ref
> error path.

Both are real, and both already have fixes on the list:

  tracing: hist: free var refs regardless of how often they are referenced
  https://lore.kernel.org/linux-trace-kernel/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com/

  tracing: hist: free the var ref when its initialization fails
  https://lore.kernel.org/linux-trace-kernel/20260906133352.3815019-1-donggeunyoo.kernel@gmail.com/

The first removes the counter rather than changing the comparison. Its only
decrement site has been a no-op since 656fe2ba85e8 ("tracing: Use hist
trigger's var_ref array to destroy var_refs"), and var_refs[] is the sole
owner of a var ref, so two references leak as well as three.

The second switches that error path to __destroy_hist_field(), which is the
one that does not skip HIST_FIELD_FL_VAR_REF.

Neither overlaps with the patch under review. The field freed here is never
a var ref: reaching the err label requires one of the modifier flags, and
parse_atom() returns var refs before parse_field() can set any.
