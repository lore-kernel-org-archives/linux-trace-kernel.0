Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A952F90CA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710312; cv=none; b=qokMUIpA933kPX3pfM7yFl+3Y5J66KJ8ifg95LZfa0qXmHVUdXLIwsYub6w9knASs11v9AGYG1PPgzrev8aCkW3xyxI+mLIVSu+aEblBTxnO/6pi7jnMG8GzIRAdBG8PK7dI7WB9Xd/6VdccP8xN9dZ6vB6v1C2oIKOgSMBROPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710312; c=relaxed/simple;
	bh=TxpGRGw/pVRDHTZum8aN1QNo6n/+VR1tW4e6RQDKvGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhELvF7wkajGjp7VGfiAWZIw89bCV9X0Stqf+q9DP0R4sp9K3ZlOAJj0Zs0ADkW1Gg1RIRL8zSwhdwwKLA0FIe9zx2W5Kw6XYAoaPgjfrRHBiBxd68BJm3pIyj1CFNbkTVYW8IJsGLbQHC+FpX6Ib225ZGIxohibL8VkPMKvvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaxTiE6R; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaxTiE6R"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787da30c53dso59550347b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764710310; x=1765315110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYhGqDRGCK+cJn0UnOIQPro7GrvnzPHTnrrQsLBmDCo=;
        b=GaxTiE6R6LfqBTW+a8wBQm98OMcMnEZWZBOJDunJdO7eJ0OwezQO2qKKJvw8HceFU6
         Cub7mz74pyHrH5ywafZLUd1n7ls0Z8vk56Vk2uqoGue1UJ6XbAseR4HKMgZaEIrQH8Qt
         6Eapjil7ZWU1f4soLbJp/bTFpXGEJ9x5Qyg8B2xz27MnXETwuVO/KzX41BtKP5DvTXiK
         F+uGavL0vmH+cAJH8i7d0CwVE8QzCiNwD4INNpIzjzsTwBVq3hXOrIqVqnvEIuHnrVpr
         rHGY6/64UnoQsl6AvBeA8y8c/MVZIVfJxwUAJXJdU60hxjT21ZGcBAqxAqm4mr3I6Xkw
         3udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710310; x=1765315110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYhGqDRGCK+cJn0UnOIQPro7GrvnzPHTnrrQsLBmDCo=;
        b=R/cRykQj5232p99sJh7T+azJU/kPtAfawACRbZZEPe/OWFter0xDkzq5q95VhSZiQI
         zI1ptIqYBRYeek+eX/lbQRo0HHqbB6inZQV/hjVQPU2poCihvC0NVuROlk/YYwXvZUq4
         3DGD3Uem4kVBUzieSwb/x00MgqkJNYBYWKT/Wr33es86u7hPwMvjsO4+WJxx2KLm++qs
         YU5loVucuKbJuQB3IJvjJGvHdPwxmC822c6diVnCmC+EnBwYon2dRV1sK7NZNxz9GjYX
         aSCM7Yi1v3Mlhzm0bagRjOVGh6aWd5U8BTkQTBt119irl9+zxVl9YN3ZK0At7/cP4+6p
         6YoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49A6jslFSW1wqzT00uCMtOkk2Q7rxFDjyPOQFxeJ/r/Qyl59tfVBBq+1iFbTkqlQhXgntb/9nqT3WwC/V1jdCwRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBp5IUYZ43EP8ezPTvMJ6vIbU3oGXvJD7qvsBYvLpPvbWREhR
	4X1dKX4EGyNVHy4zFe0bpT18I063dhSzpT5aLxHWvnic7b8hhY7/g9Ge
X-Gm-Gg: ASbGncstOrIDiw5cQN3KtgjCEMPzh/0fGGwzTRAA8iqQDNn9cdKMDbdNBzfAM7dR7+/
	6shdMntrno3DtHmfvsImWZPe1Zo+Q16FX5pAdBtVLnEx0+jAa5xBkdvyEpdfCCnqMBZvZYIvs46
	4Ruy+D8031UOeZdjuaKQCdRoOWYxU4jxGGGQqAbX+AcO0xhKE46NdGlddK2bO/JcfQPE2JyS5oa
	NA57X0T/GqSVJFxzKs2OUsZNsWD1NTZycEAMFwooyuEHN7A4Ovxb92Yg9vTlozK3gHPPDLMXpAc
	d/2CU/vJxbdIHIw1bhQPKnfjE3zvWOyINtPzCLEFQq8M8NQoNqnEezZ7vhO9G3MWQxvimGFTKl6
	oOD1MsjMWxa5m4Gj5op6qto2sDO9cBMUwpzHYufnWP4pYQJTkvATbrhDjX1zcBv6daOWbivNf9e
	yvnMPxOCI=
X-Google-Smtp-Source: AGHT+IEHsQzpfTBjBHA4dtIeH7oiiPcnL1uTXbBAuV28ldULX2+K4VUyMpGMegei8EdtYuGbElbA8Q==
X-Received: by 2002:a05:690c:6f13:b0:786:7aaa:a070 with SMTP id 00721157ae682-78c0beeaf33mr40397b3.10.1764710310027;
        Tue, 02 Dec 2025 13:18:30 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad100e937sm67330467b3.27.2025.12.02.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:18:29 -0800 (PST)
Date: Tue, 2 Dec 2025 16:18:29 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <aS9XpaiGXn2upVKB@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>
 <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>

On Tue, Dec 02, 2025 at 09:58:19PM +0100, Andi Shyti wrote:
> Hi Jani,
> 
> On Mon, Dec 01, 2025 at 09:46:47AM +0200, Jani Nikula wrote:
> > On Sat, 29 Nov 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > > The macro is only used by i915. Move it to a local header and drop from
> > > the kernel.h.
> > >
> > > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_utils.h | 2 ++
> > >  include/linux/kernel.h            | 2 --
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> > > index a0c892e4c40d..6c197e968305 100644
> > > --- a/drivers/gpu/drm/i915/i915_utils.h
> > > +++ b/drivers/gpu/drm/i915/i915_utils.h
> > 
> > i915_utils.h is on a diet itself. STACK_MAGIC is only used in selftests,
> > please put this in i915_selftest.h.
> > 
> > I guess also need to include that from gt/selftest_ring_submission.c,
> > the only one that uses STACK_MAGIC but doesn't include i915_selftest.h.
> 
> Doing this cleanups is a bit out of the scope of this patch.
> Given that the patch itself has quite a good consensus, let move
> it forward and I can take care of the i915 cleanup once it gets
> merged.

I'm already testing it in my tree:

https://github.com/norov/linux/tree/sm1

If everything is fine, I'll submit v2 with this change, otherwise will
schedule it for future improvements.
