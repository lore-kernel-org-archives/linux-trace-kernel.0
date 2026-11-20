Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183842;
	b=zrwfIuj3Qirh1Tf2WIX/kU7c7DXu5GTksZebhiDpBwiJBDLpcouCj+8+dGH1qxmourbe
	 IUKxuEmojQKbb7tPKZb4W0zfeKE7iPP42Qf69Dpog+HwZnoy4FNCzXN2985HY3j/9NteY
	 PuyTZwiLRr7qW4LSQfUqDYMX2FyDglMfnRw2LPsfhlzQo00kZ2MHP9Yxz+N9iaqXf3t0h
	 XcxKM24F2gcCrhVt/ga4ABB5cGCrLgXPgZoU00d9yllVY5fVvxz0E+QKj7s7urzZ7ipNw
	 mOuskge62vHdlBXTnQROEbRf+nKbaVu+aAczMax2X12C/bLFKTfLUsS1anXTsPQSUaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
	b=5C04x1xK+C+oBTu1nh6bCZv/4sRuaeXHk7WMRao+/Jbz6uDHypzLHdf+1F+b1fzsFLuj
	 64JyZ1V6+99z2V/IfBCWqbZCAaNrr2tbaAOOKP5MWDEPI9Q77tJFE8jyPQauJyG0znQua
	 O52oxxa4C+fcd4bxpHJlVbZ/I+NlHGgmSikTPeep5oy6/i8Btbu9rGaPXj5XqLaFlrXB4
	 IWN8enxWsfTVUCt9HyIPMP5ORMb//IV9P17YUfWc5J4As/YLXfGU+laJ9Qf4/m7OGrO/1
	 dhQ4Z9bEZYKh0FeyxZzamZtSb60CFrxGQ9SVkKi3JGSCpJTDfXR4NCP3i1h0iGSHV2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GtG1iaQR;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72E606A32C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF72E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GtG1iaQR
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so477899f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795183840; x=1795788640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
        b=GtG1iaQRI9u9ARXabDEe2D8SnnTyfL+8UjK/8tqYjNwSU2a9LuKhrlTU/lolo1fBCy
         RDXey437ySP9hiMo5QnJD6PtHaw+F6Wm4BqNZ5ctCKbAFymc2+vqkB6N6NXnQATAuFRD
         yJb5e8zbLw74CQfoie3zzYHaCY6EU9YGVeRppeU8xhgcUI60o0ILXKInDYZh1OPny0rP
         euD7j7EKrlNYddojjjsLrgMjEaCgk74eQrjoFa8jw3DzuIq57Zg2AbYdM1+ZRrk9PgFs
         cU2/mDTVEffUIcg1EQR80oRe7thSm0zVOcNSnsDNUgyUVQfMBfSB01AnLEf87AeP79MZ
         VJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183840; x=1795788640;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5S4P9EVhrzfLBPEUlAs5RhZwbxTfoymelcBjiUJ2aGo=;
        b=KDLs4W3MLZADE8V5ipUaPfJ/xSq5UTvSkBhCweBvXo2bQClh+PJ0sa+6UjA3975V9l
         HQcKuGr1jbO4UWnKIZ2QagJxdocj+PKlXrSj+hrqsILD6MN2Uqivf8rTxFDoJg0aeWj2
         HyX5eLtv+VmtUrQm+BfdN115B1U9uUGpx+9NMfWaZPQP8hTdAhAuHzH4N9x8JR47WdPU
         ZN2c92N4n+g+s12jkjwfiVyimnNWWsVC0vL0551yndOHc5xUwIy0QxbhSbIg3lYen2dZ
         L/JsVh8REKWg2sUWCYUEdoXqt88lqlv8dT68jQidpfqvQdDeUQ/0mlbruax8yylDpsHk
         sGRg==
X-Forwarded-Encrypted: i=1; AL+hErHtmWetgr0hpYzs5pfAMdKgWy1UnoBiNidBu85975eBmTVkfi5jt0wGlq3IIPrMyRw1saFKLKrRmhj+oq4CdgGvAu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9shyAGceKwPBUXVviqgeUj2tqf5Cgeru4AFMHIC5EX6ZjEwNBH
	o2YdqrFEiuxRwN6dS7EIJ4XpdPek8asK5GCiUurl2aNUA3mOdTmJXqy07/EjFOo05wk=
X-Gm-Gg: AYBFou0q9Jk+KroLOxjUdJWniZykHPIN3sgU6xMjtHq2AeS7fMSAiO9GkU2Y8kexgz8
	t8f1FGWvzw6KrOPTJvEkpuNyW9Y66e8LC2eqgk2dCBC2tQSeIZ63rNktD0IW+R0vYEmYLQOPRbj
	Rwjl6HN+iZu8nDPnTS5yCNDS2JRB9EjQPhbDRe/5aGtBSfbS1K0/VdLSVSfxkMqHkFJOhZ4AQ5+
	+7LtVrH4a0jlUlmO0jRALwEnrxoXNtMELYfOSNp3EEnwR3FYh+FnRSgMgxnvzQsT7Sx0qdWOIBE
	JIMrrKbpMsSwfiBuAcfPX3mNSwP7Jh1YXjnSfUbsI6ajCv/K4fIHqYThJpOBQiyIodm9aDeiPZC
	F7Jo5akspUyR0iT9GLvxvuRo8Vt0V4mZEcInLQNOZujiD4RW03octoZyVpinM2P+pNuokQX9u03
	9sel6wFB/cgFwygZjqxh7PBaQC7SVqhkShLu9N5GBq5MiuK6vOaQywDR87gW2nbOnAllLX2P7zM
	E1RnBF4rcxb94V9//p+uLs2fLerqVcaSWpU2jTCgH+zZvDi7sOfu2eSM0eaCW3R2L1ZZXKYJsmY
	9ss8d9aRcOHx0OAysliVwR+wHoMPhOQJUjT0fy77cAehKEyG66xMze70qmaPnfBi5JKEhBbjtLB
	6i9xdxTkKgmm4+996
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4bb8881d4damr71087005e9.28.1795183840190;
        Fri, 20 Nov 2026 06:10:40 -0800 (PST)
Received: from localhost (p200300f65f19a9041d3eb07d772156f3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d3e:b07d:7721:56f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb895f66e1sm37012445e9.0.2026.11.20.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:10:39 -0800 (PST)
Date: Fri, 20 Nov 2026 15:10:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Longfang Liu <liulongfang@huawei.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <awBUG7-QzXplEiUT@monoceros>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
 <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>
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
	protocol="application/pgp-signature"; boundary="76ybofus6n5n73yb"
Content-Disposition: inline
In-Reply-To: <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>


--76ybofus6n5n73yb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 10:17:46AM +0800, Yao Yuan wrote:
> On Wed, Nov 18, 2026 at 04:56:44PM +0800, Alex Williamson wrote:
> > Driver overrides are the standard mechanism for binding vfio drivers
> > to devices.  With the introduction of the support_driver_override flag
> > in the core driver struct, it's now required for drivers to declare
> > themselves as driver_override compatible, otherwise driver_override
> > bindings will be denied or generate a kernel taint.
> >
>=20
> Hi Alex,
>=20
> > Set the support_driver_override flag on the driver struct across all
> > vfio drivers.
>=20
> LGTM.
>=20
> Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

I missed your reply when I sent the next revision of this patch. I had
to trim the recipients of the v2 because gmail refused to send it with
everyone on Cc: who was emitted by get_maintainer.pl. So please see
https://lore.kernel.org/kvm/fb0df5c89336b77a373ae0f890f63427e4adbb28.179517=
1088.git.u.kleine-koenig@baylibre.com

But also note, that if v2 is picked up using `b4 am`, your Reviewed-by:
is considered as the patch didn't change.

Best regards
Uwe

--76ybofus6n5n73yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAVNwACgkQj4D7WH0S
/k5TyQf/eHBkTiGwub1DLzfSI9Ji/DkzXua0OriEhTmok4cd+2dbl8OfLn0CXg3e
B7W5T3PuQPmIapUivPRGpIJ31hN6+UScHDdfNvj1Xbret/ZoqA+0l48dqU/ikpgB
X4WK2ENvhE+glZpB32rPkpeMadqauuBUmh1TjWnpLKn4QmgLyf+pHIJSnUmH7XkQ
BV2i7AIctyUc2PP/Y+URhj62+6B5pxn3+5BlligAvpjkpg98TxVTctcCEgP4apyk
TI6uZtnd9maFMXHbUJHEArWhVKI8FLAzZySY9/E7u4+tsY0gz/JMib7RngFR2IY4
MPZB/liFV473f+eDblZh9CKsu8DAJA==
=wiOu
-----END PGP SIGNATURE-----

--76ybofus6n5n73yb--
