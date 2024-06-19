Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0015B104;
	Wed, 19 Jun 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831628; cv=none; b=NolcveSv+7JqCrKXO4bl+5XM7CgXmxyGjUKNhi1Gw03uygE0fmjfaeT0pFdYcXaYJR4QJ9DaXAYX7CVH0U6xqzZo5TeAojOJRpRN0m/eLVfo/zQkJUJyK3IE+QnnJsw1XL1lZ15bsXxFYLXivf0o8xMjHBgRAg4opGimiaMh9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831628; c=relaxed/simple;
	bh=FiOASsPSntmMOfdoG/0TMh7Rv2arwOqOOOaTcPZum8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3bM52rEzkKf2TkE7xKFTPzciP9XMYZhUvttNBE2WulAqKSnglChM8sKusfYFeRwu6hMQtgKVX+J6sOBEKtDuOp2W3+5E9Jtn9xeQqbEB3BGktFQQmMxa3a+SsOgDJkzELDaBfrwJoeIYfEUKpm7UvGv3vGAgqqvczqhmSRJrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzi5q6ai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzi5q6ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0DAC4AF0B;
	Wed, 19 Jun 2024 21:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718831628;
	bh=FiOASsPSntmMOfdoG/0TMh7Rv2arwOqOOOaTcPZum8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rzi5q6aidFOiuicki12iUTGfGlHAegabeRfFEx2/R0Xx74agz0lLyblOPaq6fFCau
	 GVGCwnGUI2nRtdZypIDmNs2NSFn8tjzLrkvV1U9zBhuDOipe7bvY2A8cf7w4YeOGA6
	 2lVbz6BY+a9k0xqybaF1s8SfAp87gsZjLAdE/TmMeCcV3tgRiQGTEqGyqPxdMvemkq
	 Yepb3OXTPAY8jU9dhJ9kNFQyrG3lWYy/JCsk7EhXU+8HR036ucfL7cIrlWXvnNFlo/
	 kXPF3mxlBN654Q0qLYV2MGjV8r9fXQS+/CFmuswvD9UQJJi6CN5Lj1wlJon54oK8Rx
	 B5lmFnq1+CUxA==
Date: Wed, 19 Jun 2024 14:13:47 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/test_*.ko
Message-ID: <202406191413.3A40C9F4@keescook>
References: <20240619-md-lib-test-v2-1-301e30eeba1e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-md-lib-test-v2-1-301e30eeba1e@quicinc.com>

On Wed, Jun 19, 2024 at 01:59:15PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports for lib/test_*.ko:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hexdump.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dhry.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_firmware.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sysctl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hash.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ida.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_list_sort.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_min_heap.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_module.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sort.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_keys.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_key_base.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_memcat_p.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_blackhole_dev.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_meminit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_free_pages.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kprobes.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ref_tracker.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bits.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks for chasing these down!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
