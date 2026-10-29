Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295561;
	b=JvHspN2e2vNhdAW06KlBNFcPE4ebLwON1ipviDcuZggYRAEJieT6xoDJ8hLuBKXl/u4a
	 UacL8gSozFQLd/6G1OLW7P68cwPHlsGDvdqMbk6Lvnr6D6GdM4xZ/0ABGXEdr7GzkkTBa
	 SuDJwkmFyiW3wmQbCJLn5ke0qgap7ew9i/5vgN4uBF5rrDPGjOEEY9iiW1VuylqMqfBlH
	 JmJrdSNjstwbs5Vbnj5fnm/MjwbNBqQVlBwdNZvmQFbQM4EjcRHDERrme+XCnuHtJw+i5
	 L41+GL2P/afxu92pQmW9ZH9FFYdNQeX4ltLCini8nfrNF26qYRvxoiOW8Rya37EZL3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VxKnxxpthVZvnSjcILi92P8UHB/DkKivIP1tzJVYEyI=;
	b=dy3cZVh6QQhRc/hzcL12foatavpO7e/5ZAp8IjM7m3NR5Q0uxTEJNqbpUeXD0CzWZyQ5
	 dDYCB8Wy5bCAmw6j8fh68pjU3WJqF4UdN0+8u+IVBvR6HOilDxQBBNaf2Vtg17mNfjZTG
	 Lmf6WfZP0Z+fy9o6h9OqPWfMUWnJ4gWOZyLA4yXtZqRcb6enHHA52FaFXgQuY5nHr1gNK
	 l2yvq+kowE6r83vVOSkTUVBvhdN1ND7f/Ix4KFMHewj2EJWjL/KsbkawCFWz6JHsYBDwD
	 L3Qm3WQk0//Vj7b913oxZGbcq/XApIZAEyv/QnO4qkoLGMpgTdFcJE3iwmSoZetFo4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MKktIpQI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE98606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 17:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE98606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MKktIpQI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso24904785e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793295559; x=1793900359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VxKnxxpthVZvnSjcILi92P8UHB/DkKivIP1tzJVYEyI=;
        b=MKktIpQIJblhwONy/EFQnvOcJoJNVS/qb0uFX43/yrvQxg+k1Ha2ClQk5hEE4FF9Qo
         io5cWMTquRCrNT359I5fvkpK8CXr8Za76kdts6pe7snQ07myzBMYYe098M+uRS5ZT0kG
         Tw4b/BUx0MFSVAx/wmMGdDSuMVqL0RVuvWkPaWkeoGqudG/YhVr064KXafY2u/Eix4x9
         B4rB6ahwthYp29bj05SWvmyhLoWzGdweTBVVTNOxuuxrVb26vamDabXpDtAxQru8ABc/
         E06G5MhNFJvVo6VSm0gLjj/6rTpATeaDw5jahm0Gvfv8f85nDrYBnatqw0gE+RKMaW9j
         KNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295559; x=1793900359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxKnxxpthVZvnSjcILi92P8UHB/DkKivIP1tzJVYEyI=;
        b=KOX7guN4dQGWNj7uzgsBMbzWp7nkdZ8CU8/zoJQW8IPr6exPy71jdvOom8fwWDFteD
         TeSUvIa0+HCXdhfi+418KcjVxyAkAMzCyo06HjPY1mRVJMYlxKx/t/OzbmVroCLvCFyI
         fljneYhkzvYV2rWYfzUId3QQP46Qt/Fj/R0A7etEWu8h59q6eEUTXpBo53Vn3yz+SzPm
         bK1F9nNZWX0cCIn+qQ/M+z7OyWJ1EyO00oTP/OcF4Mk1+RnsqBZSWcbDYxuaEhODpQgT
         ArvsJNhqfC2aDC3N4dUKBuTlEpl/CblGL66njiooojeamHTHc/rE1+1AFMfIliP3Tkb2
         QEGg==
X-Forwarded-Encrypted: i=1; AKwUvBwPiGUVuTA78MTOCxHpxd+BdlB7B/9O6qNu3KY1qpOb2bkA0Pxgc3XY/kcfP59+NWakvcdJ4BU333stSPGo6GqR4Ms=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDAOq+MCdfHAdtx1Zw16+ipMUjt9QwbAOwxY2DIp2w8GLHugQM
	G4F8FeRqvnlqHqzKWlLu89/bSu5wIq0Ap6I8W7kUCQ2bsen6e+sFDxq8Q8Py3NHe6Aw=
X-Gm-Gg: AYBFou3KfEUZV8bgtm1srhZyzSGLqmaf0tPm/jYF1pv/0VXVKVg32xVPURPx5P2+t/3
	+Krn6qlihCcGQIMZighwvFdskDpoV9jwd1HQErCbv3yxMYI2nLRKQGZ7wJEUO7qL/ErQ/9qe7R5
	H3/lGnEuYq38f7JX6RmW1JAKSBc2s/Ixra5XxCXtkArISrH6uQqeaA3+GMqclm9grKCW7CBueXY
	ZcLT0P/Kg02K6nQsy++xhzSlpcM2X2HDdwt40F2tCbw1dISEcQ5Be3n6C+eaCrb+djlIDsxPlT3
	6Y1AVSYe8or+d2pZOJUTp7slDc58JiChtfUjQztj3KnNfKvcam6MDLBuF41j+nt+zOy3E4U5LJp
	X380k3E4Sda8tt5Op8IbclI4v5dazgwHpxk52sbjeNtQXY8MZmgPr+5YA4Q7s09ts2LCMk16Kxh
	CvcsPfzK5angZ0S6e6x4RqA0wc1vemgFcY3jC73GheCXpLlKDopVcpzlqek7zTTC5RFwMhCzGBc
	YtzVYvb4/EjuhAAZVgpA9ydIRQXl+/QXOgRIYJnNwIYyFU8Dxl+BP7+pnc2yeaCVbTR6ElbavJS
	0geXKFAI12aMBusKY1bjrlO78AGPa89kDa0=
X-Received: by 2002:a05:600c:b8a:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a96667c848mr135986785e9.10.1793295558589;
        Thu, 29 Oct 2026 10:39:18 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e6df1e458sm627445f8f.5.2026.10.29.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:39:17 -0700 (PDT)
Date: Thu, 29 Oct 2026 18:39:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Michal Pecio <michal.pecio@gmail.com>
Subject: Re: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
Message-ID: <auODHyLrfQylISX2@monoceros>
References: <20261028-bind_taint-revert-v1-1-7c6b9cef30c9@linuxfoundation.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6fyrt6fnoykrkwe"
Content-Disposition: inline
In-Reply-To: <20261028-bind_taint-revert-v1-1-7c6b9cef30c9@linuxfoundation.org>


--l6fyrt6fnoykrkwe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:42:15PM +0100, Greg Kroah-Hartman wrote:
> This reverts commit fcbfaffee51a452cc8efcbaa3b88ec4595678424.
>=20
> Turns out that vfio is a crazy beast and people have been "relying" on
> the bind/unbind debugging feature as a way to handle passing through
> devices to guest instances.  Because of this (https://xkcd.com/1172/),
> let's revert the feature for now until we can figure out a more agreable
> way to handle this such that normal workflows do not taint the kernel.
>=20
> Odds are something like what Uwe proposes at:
> 	https://lore.kernel.org/lkml/cover.1790612298.git.u.kleine-koenig@baylib=
re.com/
> will be the best way forward and will be revisited after for after 7.4.
>=20
> The feature was originally intended to stem the flow of unnecessary
> fuzzing reports of "broken" drivers where random devices were being
> bound to random drivers and of course things were going wrong.  The main
> syzbot tool is now not doing this anymore, and hopefully no one else
> starts it up again (but in this madness of LLMs these days, you can't be
> sure.)
>=20
> Thanks to everyone for telling me just how wrong I was to implement
> this, I appreciated the feedback :)
>=20
> Link: https://lore.kernel.org/all/DLIL9H50MALI.3JROXYEEUM3KU@kernel.org/
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Randy Dunlap <rdunlap@infradead.org>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Danilo Krummrich <dakr@kernel.org>
> To: Johan Hovold <johan@kernel.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reported-by: Michal Pecio <michal.pecio@gmail.com>
> Reported-by: "Uwe Kleine-K=F6nig" <u.kleine-koenig@baylibre.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 52 +++++++++++++--------=
------
>  drivers/base/bus.c                            |  3 --
>  include/linux/panic.h                         |  3 +-
>  include/trace/events/module.h                 |  3 +-
>  kernel/panic.c                                |  5 ++-
>  tools/debugging/kernel-chktaint               |  8 -----
>  6 files changed, 28 insertions(+), 46 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index a208811ad525..3d312bc17942 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst

It's not part of commit fcbfaffee51a452cc8efcbaa3b88ec4595678424, but
conceptually we need=20

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/=
admin-guide/tainted-kernels.rst
index 3d312bc17942..fcb8b9734548 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to th=
e aforementioned
 script, but if you need something quick you can use this shell command to =
check
 which bits are set::
=20
-	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i=
&1));done
+	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i=
&1));done
=20
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

in this change which was fixed in commit f1850e443b0e ("docs:
admin-guide: Handle TAINT_FORCED_BIND when parsing
/proc/sys/kernel/tainted"), but that commit shouldn't be reverted as it
contains a simplification that we should keep.

Best regards
Uwe

--l6fyrt6fnoykrkwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrjhMEACgkQj4D7WH0S
/k7pjQf/fZLeX4jg8q6vdwBmv7dGxKbev3ARRZTtVOacOQwftIek8l6UKQWlMwoG
/tiokVc22lkSxsHq47w6eKUKpucHydGzT8Y7OZvHNjOjZ1o9WS00lJRh6uhVTh06
MK6k0za6dBbrOWnTBeTGZuWlLCOQKpDB/6t93V1fIYYJSd0ir3GpvVZzfM16Pk0d
opyBimIxlfjCuxzRbj7DZjzv0I5PbjXdox41VKx2cx60OzFJdN0MKZifLp9yNV4s
s6Tc4Q1oK/Ih66hhbojNkTp6Xyzsy2m0lvku9N0DitT5/VXqoI/mdedlPK7tFWeh
qZAoONEgzf9TmSM0/P2g0K+1mpLkrg==
=/byF
-----END PGP SIGNATURE-----

--l6fyrt6fnoykrkwe--
