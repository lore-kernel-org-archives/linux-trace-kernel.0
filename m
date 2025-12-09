Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DB1C84A2;
	Tue,  9 Dec 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295937; cv=none; b=hENTilDMDmT2MjR5IXkwp+QbCFM3vottaiuZ7YTVeoRL64VeLuUfiE2TZmTMBSDIVHliLebLzwiExNKTXKRs9j2iXba+Q6PMoZlSivlafj6c9LMMr+BiwFgigrJDaypeBMeRfWQ59S4OSyGkOh4DxYzy48PdVJyxBzOoSduv8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295937; c=relaxed/simple;
	bh=hq+Gp4/eUNzcAoVmwhNTcMabF3wmpaL86Ur2QN8irHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnMASSm8g7iKDgwGaYvNZmDGv6mzUqIVCM1Wka3A9ho/gVqpVlVk23N4q9htVLD9u8hOgKqxGvzb5hdh6auAcQXmQWe5R5Cw6FRj6JYOeNBY0T3MPyV/XLUQcZzDmwjJPsaa3NOs9t3pu8z68awb4OZog/ZzDf7xvdJ8iL+LPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWE8TelC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWE8TelC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC93C116B1;
	Tue,  9 Dec 2025 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765295936;
	bh=hq+Gp4/eUNzcAoVmwhNTcMabF3wmpaL86Ur2QN8irHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWE8TelC4VxDdU3W7h2EonB0m4q1dgzzaccunK03E3kid+i8yRHZDX0HduYKKnwOz
	 XbCnQ7l/oQZlncLBeK0pLg559EkMh4wiX1PAw0SV/krZuR9AH8dIA7vI1Qdg6algna
	 Bs//Sp0CEFcXSf9u2yx8qJuqrUv/3bVLH2xuSSWHWd+QlegHHtjMSdpJ5mDXGgD6VK
	 nhVCJScAsIXfPykXJhVv0VzeFpLLxaF55a7xLF3rkxMsCKhFMKo2Mme1zt1AO1GQC8
	 +CWfLGxIkLFgQYO5lQdf3PEBwi+Xxfl7YJkekDMFoZWnOriZ8YUdRTbX7WglLQUuBL
	 WobvXc6+RzZFQ==
Date: Tue, 9 Dec 2025 16:58:52 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christophe Leroy <chleroy@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	David Laight <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/4] kernel.h: drop STACK_MAGIC macro
Message-ID: <heichtdv6trkebioytkadhjdrs6peipe5hq23ilt7nruxdrsuj@ev33nk36kmot>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205175237.242022-2-yury.norov@gmail.com>

Hi Yuri,

On Fri, Dec 05, 2025 at 12:52:32PM -0500, Yury Norov (NVIDIA) wrote:
> The macro was introduced in 1994, v1.0.4, for stacks protection. Since
> that, people found better ways to protect stacks, and now the macro is
> only used by i915 selftests. Move it to a local header and drop from
> the kernel.h.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
