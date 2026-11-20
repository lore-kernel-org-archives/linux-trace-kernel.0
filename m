Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200506;
	b=odT4PYUGQRdkvkVxhSEQC1IE3qJUCECfHTOd4hX7kU0wGhHAF6ysezHZiLv4dbNwtW9Z
	 BiGWNUzAaDvgInZ3+J+dVQjzg+yHNLnYcIPSUoolTOYytg6YqCF5242z7SL723Mhh18Dd
	 8C2RezjnAf/UKD0+MkI4wr3oXtD7+MHgskGEV/+Ncmkrz52UuPBiw+M7JxGnYNUYFEN6c
	 hVkYOzfcNChSvWnuOAr+/vFCH/q94D/PpeKqaUBjBlJfr2sORkdQfSNEe7KZ0H68K4Fdx
	 dy0KqRc20xZanr56urBia/moDt+otLvoY0+FUj3qfBdoF+4g/WAVw+lWEnjnczlzcIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200506;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=rXBlCLAIPxZIrnxc5TaUZs68Bkw6of2txEBVWp826uY=;
	b=bE4WhJkAHpS3QnSv05iR0sXuzub0b5IGpRoY1vd7dK+BdOOiYRvARpQfKDgvVw0hlLVc
	 N8+Zbve2wSSafa4pjeulkcC+ElWKFfvwgXRMv61F9FR1k1sGhHCWx/QctO5WRt3jHKwdY
	 YdI2gGQH1LF16bpgxf+jBoQL4pIFGBPw1HcNpxsEt9KXa0zd9qn6s46xls/eJj+IhVQCt
	 J/QB/O5pRry5BkUmaDzajUl39IGa4wOsJHwmLXn+xd+HkpLpxlpP21Kb5duBM+svzLeZQ
	 cX/i/r800HfbitmnChhlBbgMx4TgkXKGP6OlmhHnkRygCckp+OHm5mUrESaRfwSyCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=qi5royQj;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D960A260D;
	Fri, 20 Nov 2026 18:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24D960A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=qi5royQj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rXBlCLAIPxZIrnxc5TaUZs68Bkw6of2txEBVWp826uY=; b=qi5royQj/MxjP2EhLMDrPzFRUV
	QRQtkFov2KwEqvFQVTOm9DxW4/AUZmmIDMDYnSZEOQBypgTf42igwM3yWgxWGuBKCT9mujN2EOfsH
	yLEFvhU0RkbaBglJCpKuJDCJiqzWxFqYB2XosUDmaVOJRK81TXWR1SjyZ8gxCYL3Z4ZbFP5qMv/I5
	p8SstMBI4S+nFMDf3R/KCTEUZ6FL0cjNJU8uANYvOGX8MkZQsm5K4JJXnQKnJBz4pJqYayspbIho8
	frFzMs4cLZpWE9l13n56CM15dG/+dHaVRbqVuml+pxnflRylzPlPmVdZb3e02jT10AF9xwhjyUbNv
	glh3sPhQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUTei-0034dY-2b;
	Fri, 20 Nov 2026 18:48:17 +0000
Date: Fri, 20 Nov 2026 10:48:12 -0800
From: Breno Leitao <leitao@debian.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bootconfig: Exclude alignment padding from
 bootconfig max size
Message-ID: <awCV4GdVIRNJN6ty@gmail.com>
References: <179495924003.237695.10973676765152260584.stgit@devnote2>
 <179495925054.237695.2777053796977822521.stgit@devnote2>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179495925054.237695.2777053796977822521.stgit@devnote2>
X-Debian-User: leitao

On Wed, Nov 18, 2026 at 08:47:30AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When attaching a bootconfig to an initrd image, apply_xbc() appends 0-3
> null padding bytes to align the total image size to 4 bytes and includes
> those padding bytes in the footer size field. As documented in
> Documentation/admin-guide/bootconfig.rst, the maximum bootconfig size
> (XBC_DATA_MAX, 32767 bytes including the terminal null) is not supposed
> to include these padding null characters.
> 
> However, both load_xbc_from_initrd() in tools/bootconfig and
> get_boot_config_from_initrd() / xbc_init() in the kernel check the raw
> footer size directly against XBC_DATA_MAX. As a result, a valid
> 32766-byte config (size = 32767 with the terminal null) gets a footer
> size of 32768..32770 when alignment padding is added, and is rejected
> with "bootconfig size is too big" depending on the initrd size.
> 
> Define XBC_DATA_MAX_PADDED (XBC_DATA_MAX + BOOTCONFIG_ALIGN - 1) for the
> raw trailer size check, and add xbc_exclude_padding() to strip up to
> BOOTCONFIG_ALIGN - 1 trailing null padding bytes (keeping the terminal
> null byte) before checking the unpadded bootconfig size against
> XBC_DATA_MAX and passing it to xbc_init(). Keep using the raw footer
> size when truncating or trimming the initrd so that both the bootconfig
> and its alignment padding are removed.
> 
> Also expand test-bootconfig.sh to verify applying, reading back, and
> deleting a maximum-size bootconfig across all 4 alignment paddings.
> 
> Fixes: e1cef2d4c379 ("tools/bootconfig: Align the bootconfig applied initrd image size to 4")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
