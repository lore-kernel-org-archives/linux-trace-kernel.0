Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2F4A64F4;
	Thu, 10 Sep 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052226; cv=none; b=QdIQYtLsdsj3FETj6NrhN4qDJoM9aqF9Zu+5ezP8odar/zNkxERwGiLjDSQ/FWFrJcsYijT3QELEmJ+q4mn++H/WvkcDs+HdjkpjfnzT1ZXqnuV73bcETw8ig/FHfrijSUtew82LrmtrdUQvao91dVZRjbAmKXR9bsofUQcbJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052226; c=relaxed/simple;
	bh=e63b1sqbBEPGPPeGC6AARhf4ApY5UhKmpJBsNl0sOrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZFY1zDHH4VIEQGMm+KYYEiak0i2rKW+pjo/juFUWo5mlb+Pq6I3ib1rQdOkvCSnPSLFUfge+fIzjwAXKpvPS5TE6DwCvWEnK4na9JwE99o7npFo9iybVFvsKhPdYg8TNGkUkN6R+AvWVX3wnYY0oc+K1+3CmyMxGEG3s2Oi95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vI0wuol5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vI0wuol5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gUTy1mP3eu8JHlGcI+Wb2zwJfuGbZLFoTbFR3zt6qs4=; b=vI0wuol5Z9rAEX6hwpkVCTdpsJ
	sRoXe/jRuU6yY4IbrOk6F3q6L9nocmNzuQqBJh3blSlNMlmgTuJInLBxo1nnyrHhhZJxz2DrxUqfo
	DcmArIfv2VrzXl5yxg31Sk4TpcU/sjNciTUBhpbJP8oBxw7QMjN3bzCu25BthGkc1Mrc0IMuHwVcR
	ElfgEVhkZTCflPJfXJU19fGsGjXhF6QHC7BLu/gfD26lljZa4y6/uu4J+ZU1ZX9fta/VryOkPKSTU
	UmAZBtuvyp0NOgekmuacExP0aTs15kRB8y+KDv2BLvPmJ0Iu5uj6Be3q93kl0e0J/41pyOTU85idp
	MpBVaOCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4gCw-000aZj-0e;
	Thu, 10 Sep 2026 14:56:58 +0000
Date: Thu, 10 Sep 2026 07:56:53 -0700
From: Breno Leitao <leitao@debian.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v3 1/2] tools/bootconfig: Fix integer overflow and
 truncation in size checks
Message-ID: <aqLFKS7H0xLzDly0@gmail.com>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
 <178900556473.200943.6236071503689711862.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178900556473.200943.6236071503689711862.stgit@devnote2>
X-Debian-User: leitao

On Thu, Sep 10, 2026 at 10:59:24AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Sashiko reported that on 32-bit systems, if an attacker crafts size in
> the bootconfig footer such that adding BOOTCONFIG_FOOTER_SIZE wraps around
> (for instance, if size is 0xFFFFFFFF), the size check in
> load_xbc_from_initrd() can be bypassed:
> 
>     if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
>         pr_err("bootconfig size is too big\n");
>         return -E2BIG;
>     }
> 
> Furthermore, on 64-bit systems with an initrd > 4.29 GB, comparing a
> corrupted 32-bit size (e.g. 0xFFFFFFFF) against
> stat.st_size - BOOTCONFIG_FOOTER_SIZE can also bypass the check if
> size is not bounded. Similarly, load_xbc_file() passes 64-bit stat.st_size
> directly into the 32-bit int size parameter of load_xbc_fd(), truncating
> large standalone files (>= 2GB).
> 
> In both cases, passing 0xFFFFFFFF to load_xbc_fd() truncates to -1,
> resulting in malloc(0), an integer overflow in read(), and an
> out-of-bounds null-byte write.
> 
> Fix this by:
> 1. Rejecting size > XBC_DATA_MAX or
>    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE in load_xbc_from_initrd().
> 2. Rejecting stat.st_size > XBC_DATA_MAX in load_xbc_file() before passing
>    it to load_xbc_fd().
> 3. Checking size < 0 || size > XBC_DATA_MAX defensively in load_xbc_fd().
> 
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
> Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
