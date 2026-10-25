Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932496;
	b=DqUR/NJlKertwq/4QvlYjEVDRLTtg0dPFpy0cX4eeq6at3iul+uPeyazWjzbkkJ69yRF
	 DQdIqzF7G7lpW3DWhUjBiAC9Gmga+kEEhMrGLjeKPM86pCU5X0ed7Q5Q6AbtwoO5Rz3k1
	 1J1lmZ7t3aJXmbeLuT4c7ajSPo0GppivHqp6I0jOkpHBX/QmPmpzKIH8uw1KOGMiyU+6E
	 mzoUrKnCkm0hQa66Pep/6H5ePNX/vqKQUeftKaqgqLKh6e1wo1klh7a6kHF6Kmdh8K51G
	 x+NEOt1oJh7R3oEzrAFXuftpuiPi8AY7oO/FDn611KHVu7ZcedpTmgYNodsiRqSboKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GFk493A56cYfyK4uM8/JlxklDpnCWTgb/zmDZtIoFro=;
	b=uymJba0LP4VPRMeHUXad3iMmjI1e5EStljT3E7g0t2CLTD9X5SmYIOJwQpPpASjILkWH
	 u4C1Ud+Njv2hQfh/fEXpn8mC95E8K7DSVvlSZDUFf7FWXUZTR4GMIRbCU6s3Gkf/QPn3F
	 fXPHDHyS8SnN/eDjmkJ0aBukpb4K1Kuhi8+FnbT2osnm+rESrXg1KyOHx6F6z0Nokc5O3
	 pnJRQOxDrmIh0Pun6IFKU4fwPDVNpsY8XOUG9NJVTdyc8KS3FQjinbICcwPpSNnDaiQ3a
	 jmat0jRHq61xxmnMqVdOGNy/M2jdgXaB/RV8QCA8PPS0UH8iX4MgeDRQeTc70N5w/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A4606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 12:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348A4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so9334945e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792932488; x=1793537288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GFk493A56cYfyK4uM8/JlxklDpnCWTgb/zmDZtIoFro=;
        b=pg8FDG9OpzKln8+QRdvhMAtMVp0WQ1NMYaLASyxAEYJWLNST/WK5rNIhMJud+ol1qL
         fnBQe5FIbncQ9e7Yf2jY5Avm2y32XlQwi8zLdEdscaiuJNlhCMoPO1s4R86eAMZm65+N
         4wN667A/guovDHJDdgGvxXS+E40NfJnWTsV/VNIYrlv42LuwoD8jhjPqOl8WFcqIB9pB
         a1e9nczTgOPdUb4RwVqkaM30MzLLvdbX8vRjHV0JGK6vlZjszCVuRfZPWEEEj2bVwOtS
         Onb1sPkJ2qFK+BNjMAVgcE1OO2VGj/K5/NoSG134pZJDNd8mh6bvz+WE17qQMRc8Utq5
         4GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792932488; x=1793537288;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFk493A56cYfyK4uM8/JlxklDpnCWTgb/zmDZtIoFro=;
        b=q0ym+Nv1GzyjmPP+NliLWLT9AFGZcZPG64ZL9EDrQzVFpW2TGMbSVSBG73gs1sGVAx
         kPB2n+9TqFkXZyVEHvO0qIqhqmwS3c0Y1Lnwe5gxq6a4a6oNs25wUCMKLgqZJrPyndh5
         YgxwJ8+V9198BhL3oDc9XmOP03W9YXUMxQfr4UcYbqWGkB1gF99nKWcwAOO/GcycGY1D
         2EsWfJO+Ve84z8Q4zWV+ikJGdTEIWmhPdWQa2L+TeEXdhsYXI5Vo+wEzFsDCZ6ut3Ugf
         LgY1sjBGNV2RTHrz6Yx28IzIT+i7dmyAtorq+kAOizSWO6REnCVlqaZv84saBhhna+gN
         QflA==
X-Forwarded-Encrypted: i=1; AKwUvBy9+ZH2QYJZ4P4AmnXAtEJI7ndKUvtsSmRPF1DIXRxxkalRvsfwS9lWiRjp8xYk8WfWQVaDVet6+HbfkKO2QeNQpEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAD8yvW7JNMqjYLsTiAUEodLgSCrkLbvqa7bzbFTxL79erfvcD
	NpuN8wdeV2LhCmHXVFpPHYief8hnWLLS+9LsVXY/1lWmGEpGypscr1NsMc0aXi06aLA=
X-Gm-Gg: AYBFou3bmZovVG7si6m1R/GrcEPdkHDCrkBnnXmd1LjnyAtkTkwzpLFCVDItaU9GwsU
	SZdnhjRVDa+b+VgFbXNBlcrVHdGpJNcQrKADIi5vNZakhLwVSlg1tMKPQ2cMllesV8zSMbptaJl
	VNepv/8yv6eQF/urYtfVlx34VyQltx8J5E+s0ajdqIm6/dJK+37Ui68BBUUtW2rlsP6jejUgMG8
	UQiw8W2rEJSHEVsbLcsF4agfSADY8vPkhx0TtTjyd6ReQYZi99rjHzbEoRVDk5kcB5VLnBxUr8f
	djrygc1iN2KAa9dD5NyxlMch9PSwV92/iv5O5dlZSw8Z/p9bXi8vvyEI/Bs5n460cBLPgn+lah9
	K3ZlteHvTGTR4qEmqCjaYQ4ofwHaBg437w8+bmMRRRTW2kXz/fk8Kmy1tNWoTCIj0hcmL2r+fcM
	dwQizTlsepHJQ4TPmfl8rlxCMx+X+RaYusJL/EJwKIa55ocNaIoh+B04biFEwu4JktIh0Nomt7f
	kIo9r3DsHx6DFRo2ZWmgLEH+f+REz3eUSxIBt8rr7AlGEj5C9+M4hJiXgY9A3QNjOuXUq9fyQBG
	adQjNA==
X-Received: by 2002:a05:600c:3b19:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a35acc7696mr71714575e9.18.1792932488137;
        Sun, 25 Oct 2026 05:48:08 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a35a04ad39sm326937255e9.1.2026.10.25.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:48:06 -0700 (PDT)
Date: Sun, 25 Oct 2026 13:48:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>, 
	David Lechner <dlechner@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Thierry Reding <thierry.reding@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <at34UOuYv3NtX36R@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
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
	protocol="application/pgp-signature"; boundary="hexcezj4rledtjd3"
Content-Disposition: inline
In-Reply-To: <2026102437-vista-unsoiled-b089@gregkh>


--hexcezj4rledtjd3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

Hello,

On Sat, Oct 24, 2026 at 06:56:34AM +0200, Greg Kroah-Hartman wrote:
> So what is the real use case here, taking any type of any device and
> thinking you can bind a random kernel driver to it and it will work ok?
> You all have specific platform and pci vfio drivers, why not use the
> proper device ids there instead, or better yet, bake-in this type of
> functionality into the bus-specific logic so that you can have generic
> userspace control of a device (like usbfs and uio does today)?

Also note that even if the platform and pci busses implement
bus-specific code to pass a given device to userspace and/or a VM, you
need proper unbind support in the driver currently managing the device
(or cripple the mechanism to only work for devices that were not bound
to a host driver before).

The more I think about this taint, the more I believe the commit should
be reverted and replaced by a some stop gaps for driver_override. (Be it
a taint or better yet
https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com/
.)

Best regards
Uwe

--hexcezj4rledtjd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrd+oIACgkQj4D7WH0S
/k6aewf/a1J79AfBUwvrOd6Ba/0Y7Snc6nW1R3bcrJe5+V181tlQ+NubUnz+DJdu
l8Jqw1xcQaALmyYYZ+CaEenSacHj9TFNREGi92ZjNkN8m6+iH5soIV1vTHPZaevX
R9oV4vf5RnsRXugZv92lNktCGbzbu2ceTDhJU4IoX5FyuqL95AVajJ4awrTw+nol
Y+gyqcgb8mzONrS7D52rBINMIjpn9/nmcPs4bVkXCZjAvPg+MFRZTpjwZ7hB3Guo
GM19dH/Q7rfMakDFZ/TJqgDbxuKHrPdU/EFkrRXiolTo+VEKvUOmiiW/JK6zrFH9
WNnJHHFnJdcfBwsazk9IIqGimnpBHQ==
=zFX2
-----END PGP SIGNATURE-----

--hexcezj4rledtjd3--
