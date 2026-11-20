Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200437;
	b=topNzUJdIRzkmI5vJUTNuEZfUCVSpFP5PPGn4W/4w3e4lEzapfZSYqVVxm+68GtK3xCU
	 51qQbG33FXG33y+XGjnWq3921wM001FyU+szuPARzSZdkhANxu1jnbm/+XGG9ECqb7xaW
	 ppfx4j18cLyqfrI9wEdAztJILfQU+ucym8nA10vPOXwqxoPD/R/a5lcUCG1yJ88NC114u
	 v/ESC2oi1ftk59bwaLR8buVZeOk7QiiE3Xyyo22+OKXXPWQj03izBLNF71bGP7+MdEqLb
	 il0CPpydSb4oRsSwjCUJ16NoNIQxSi4f88mutlmopnumOWbO01VZahOU/B9uIMgIVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200437;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=QvNQ8UvOrZsTAC+SyQ2hsqhbrbCksakJyw3ueyHejds=;
	b=Eah9p+M9u9os+jdE1BVayIBwEiJOV+AsestAzD+bXFi/158lzjEO2gkIOUoUTdPxb0q6
	 652nKVS0nvoFSWmanlaA+R8fAwE+GEP3laPl0ZJy45rTQAzpshA7+BAskkOeG6fiyspcG
	 kB+aMIfrC2LzlYYt77nZVysxPc6KupFJEu4PuW7FGEHlkTFKPJk2hnhozwZ5KVGufaJaz
	 u68KdD0GsUHFHag+oBgUu+uwyn+6MuP6RTeGa/ut2KYgqHrZ4IJMzrDVa305rnrSkKoxx
	 4cKAGBnaQqlEIyhav6pgnM0K1nuBHepzore7h8IPMtDX1YfGBT7d9yibAvr7SvW9HTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Qvp9Juu9;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A660A2616;
	Fri, 20 Nov 2026 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D63A660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Qvp9Juu9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QvNQ8UvOrZsTAC+SyQ2hsqhbrbCksakJyw3ueyHejds=; b=Qvp9Juu9QuNwr+hsllXSMbOi7N
	tomwb50LiQzZk0ut0yYeQlOwOTHsJc1sTfcNsXdQkU1skkMe2djrrKIC/Hs7VbsTUPMDu72GN2q4g
	x/TEGMAs3t7tht0sw0zsdTZmMfXJb/vH1N/Joox8iggaL6N2plPAnkBFV6EI1r7ZC1mh4FgRA/ZjW
	PeGBqUTILnmsJC518yfaA+yt0hw8qz1lvsBf+3Pr+G2rPtdxpQfXRRjo8cKYAjplMgzxlS2/MeBGS
	lARmEx9solW4xl4eQyKiMsPH7kpSNGFZJJe38yRCydgJAZxciLqFlsOIeA6ym13ZHYVziYCQ/D4qN
	wgHrJaKQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUTdW-0034bG-3A;
	Fri, 20 Nov 2026 18:47:03 +0000
Date: Fri, 20 Nov 2026 10:46:58 -0800
From: Breno Leitao <leitao@debian.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bootconfig: Free the initrd memory used by bootconfig
Message-ID: <awCVkOPTQaQUHANF@gmail.com>
References: <179495924003.237695.10973676765152260584.stgit@devnote2>
 <179495926058.237695.12800083196053168375.stgit@devnote2>
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
In-Reply-To: <179495926058.237695.12800083196053168375.stgit@devnote2>
X-Debian-User: leitao

On Wed, Nov 18, 2026 at 08:47:40AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> get_boot_config_from_initrd() removes the bootconfig from the initrd by
> decrementing initrd_end in place. However, the whole initrd including
> the bootconfig is reserved, e.g. reserve_initrd_mem() reserves
> [initrd_start, PAGE_ALIGN(original initrd_end)), and do_populate_rootfs()
> frees it with free_initrd_mem(initrd_start, initrd_end). Thus the full
> pages in [PAGE_ALIGN(new initrd_end), PAGE_ALIGN(original initrd_end))
> are never freed. This leaks up to 8 pages for a 32KB bootconfig.
> 
> Save the original initrd_end in initrd_mem_end when trimming the
> bootconfig, and restore initrd_end before freeing the initrd memory.
> The bootconfig data has already been copied by xbc_init() at that point.
> The trimmed initrd_end is kept when the initrd is retained, so that
> /sys/firmware/initrd does not expose the bootconfig.
> 
> Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
