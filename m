Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D7212574;
	Tue,  2 Dec 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709104; cv=none; b=QVPzZyDL2Nsh91AHEjouAG1R8cBszaj4ngC/bfTDE62cvdKJzkmLo8INlEfpYtZakBHx/y9MWqFoH4JXOrNs5lk6aDv1VdgCFK5UVpoTz9G0oSoQXvpw0UhrngrI9Kr0nnObiAoPWDIgHHWKFfZt8cO8g+kT/fvEKykg1wKLmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709104; c=relaxed/simple;
	bh=zlnGbwpqVuU4WhWs2PTVXFjZ6/OM80jwbLabLxCX6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtzcFbjf4S97ea47QBEEatBs2RZULapcoUdVjj4CJhfMLikvYhDdw5xCuDf3PaMr/ricDPBGGHc/IT3rXYexSPK1eN6bULCbbGQrGSMNpipFTCPrCgwShDw2t4JWtJig6TlVnXR1hViHukTcGT72r8bYCOREnWFaTBiZ4ZwE+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEd+RkPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEd+RkPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83552C4CEF1;
	Tue,  2 Dec 2025 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764709104;
	bh=zlnGbwpqVuU4WhWs2PTVXFjZ6/OM80jwbLabLxCX6JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEd+RkPgbRbzq5T2chlYo2Iy0yT4Tajrpn/YuQ0P074U2Zh3N+y6qKoW3RBlMcBYG
	 Aeg5oyrtupAtylJkmisdEy59gw8ideP5bmTYenpsDDazlz5DU6JcpMaFZ1kK8sjsuj
	 4Ly/4xMex4gn74OWsf0xBeJw9W1ygB9cKerkqm21df07PuoK3hjh+SCFEuoC10pX3c
	 hNG0mDGBzrgVbRH9tUk+gAu055vleHUVtiGhO5J7XgSpIlDJVx4q9peYaqR1KiAwa6
	 THnT8D6IjYYgxdkkP7q5gSEniu4WDSjij9S0IoEDnuvKiuHH4NmXnTrpQYGmQcqqOk
	 ivaf/ArPeU/iQ==
Date: Tue, 2 Dec 2025 21:58:19 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>

Hi Jani,

On Mon, Dec 01, 2025 at 09:46:47AM +0200, Jani Nikula wrote:
> On Sat, 29 Nov 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > The macro is only used by i915. Move it to a local header and drop from
> > the kernel.h.
> >
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/i915_utils.h | 2 ++
> >  include/linux/kernel.h            | 2 --
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> > index a0c892e4c40d..6c197e968305 100644
> > --- a/drivers/gpu/drm/i915/i915_utils.h
> > +++ b/drivers/gpu/drm/i915/i915_utils.h
> 
> i915_utils.h is on a diet itself. STACK_MAGIC is only used in selftests,
> please put this in i915_selftest.h.
> 
> I guess also need to include that from gt/selftest_ring_submission.c,
> the only one that uses STACK_MAGIC but doesn't include i915_selftest.h.

Doing this cleanups is a bit out of the scope of this patch.
Given that the patch itself has quite a good consensus, let move
it forward and I can take care of the i915 cleanup once it gets
merged.

Andi
