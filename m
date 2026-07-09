Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB947385D7E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598849; cv=none; b=po9vz1moOQOQ2WODlI4yFsHACvtIJmHuT3UHgBsqeF0E5XhHvNP3a0YZjLuR8dYC7GlfdEQhvqF/WSrQmtw4zBvm8MPU56CUcBleUQT/dUmTlshoqhvJrFQdKTVsQ+DJZ/Dlu5JelzD4AVgig4wDw5MfNlZrJgzk+AnjkdqkFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598849; c=relaxed/simple;
	bh=YnZvKQDIygqYdK3VlnHW84pqUsomarBT0zp/xBX2/0M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QupmbtgKoXJKjHJytK1TDtKCviYT47+sGiV1eJlh+QHsvC4DsS8nVzuSLyRiacixoF/ZkS+dTgw382chzO+hi1da91OB6vjctkEJ8twKdNmKMy46Z3R8QL644qu0zpTobol808yP3UGgURVI3O80deCQ7OWziRolWEP6pf99QcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YT4MpuwY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YT4MpuwY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so387771f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783598846; x=1784203646; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YnZvKQDIygqYdK3VlnHW84pqUsomarBT0zp/xBX2/0M=;
        b=YT4MpuwYTidOxe5D00Uv2LdN4oxJyKwcTLfqJD/H9jyJwjghTjZ3AOrV1LJgiuTt5D
         K53peFkXU0hKee2Nwe0IPPUuFQM4qdHpl5XCivRQBgHyCafeJkaVRq9zt1Ee9LmgSj/s
         GINXFVcZ/RiH8sHOBTUqT63u3tdtChAJ61rWv9OwNnEsvBnLvSXKSeQxlRSFW5Ly5887
         X5ESreeOtWSnSYKR1IThIzQsZcq5/F6glvSq5VazSs6A1msbmLs+W9Vlh2qlndOV3eIX
         4587i7+6ozJHrmxeFsXBJ9I/zT1cM1P6JuuBn7V7eYKBia0Uc24/sxY77Rorfk+1Mj5u
         u5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598846; x=1784203646;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YnZvKQDIygqYdK3VlnHW84pqUsomarBT0zp/xBX2/0M=;
        b=qJTtL+MBdCzC6/Yn4ZPLcH5eLzLEKvh6N07h6z2edywmjaKDYk8TzOJO6mAV/7KiCV
         k68g+mfwU7dCcLtbAgNwC9z2YH0vzkF60qGSUjRhgDSU60e/7U+aLNT/t6GeAHFe7M93
         VDoeaCvxFU95uQb8aDhL63d8vv0S7y5EGpPXj08BPm7dChcZGRhqxaVhPuiAaTwKAsYN
         c/MdQmEmRsL+RNHRdv5vkSB6lLRHcnCAaDxM1nDH2ytgWDSBaA1Mo1n6S7WfiZxxlt8S
         AoA+jaxKJpl9d4d5pxEgm9NlYuPz0esHOwJkke5/37GP7Zlbzpw/Yto1OpPZH8rlOhcZ
         Nq8w==
X-Forwarded-Encrypted: i=1; AHgh+Rp5wH6fcPA1G/GGRxFwkL6KEbDkTtU9p3wIJhBJdoF8JMpN9Q/pvepabQg06bV3UeYOZ/j+9qSXacY1IL5w/QjJxfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyomK0NilK2xp9hgO8n3H15PJiTKwjsE1JDNCZVed5n/M49ros/
	azi+YAMy9qvXCXwo5nI5yjtSdVGnAGDVilciyQ8vFdA8OLZAAj60I9j/QUusMkZcq1Q=
X-Gm-Gg: AfdE7cnUn/JWM0+Iyq/ZYQEqa9ZsSiJva397JDSRiQ6Spc3Oom7DbfW6Yk4H+/Pq8kp
	asqVW4Q6gPXdshSHM29y36g3ZbIuOQ0AauTzx6gYXFh+7jbIQ9IfL+Xx2gBYTlglB79GmlCpAL7
	bmkikQH4o79ZQGWiODyESaJNRhRoz9xVfCuKAppKT9+wXUwPnXBJp0Jn0DitlWOFibJDoi9kfWc
	xbQZhhD0qmt/Zv/OuR6qfAN7KUNo0Wx8c3H9XqUcC2FO60ofArLlTTQln5Uf6rFF/cCIHyuliqW
	99U1ZV4THH9wZRQmcjgD5iKDDZqL+Q4JY35V3DfD5zyRPb3YWhWq8O5XS2DRzpITfjFcPVdSNwl
	/Dv1/YJmd6nWoNHRLXisj/67y2VWUOHk1ixl1TPTNTbZtS6Bjm3F8Mr4ZW3oypIGW7CM9ubZd9H
	3D33t/jMZT
X-Received: by 2002:a05:6000:4a1c:b0:47d:ef62:cae0 with SMTP id ffacd0b85a97d-47df079123amr7340425f8f.51.1783598846013;
        Thu, 09 Jul 2026 05:07:26 -0700 (PDT)
Received: from localhost ([2001:4091:a245:85f5:7368:940f:9e3b:30b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e785sm50766198f8f.8.2026.07.09.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7b6316f8522944311de09e5d73742062942bd0c5333c4e262c75ae63769c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 09 Jul 2026 14:06:32 +0200
Message-Id: <DJU105LESLBJ.1O3UZRY325T2M@baylibre.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Masami Hiramatsu" <mhiramat@kernel.org>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com> <20260610171740.c30c43c5faee0beac3ad7546@kernel.org> <DJ59B5LEGPER.3UURGUC8IW7E2@baylibre.com> <20260622135659.ff84ef3b831a464b802d7c33@kernel.org>
In-Reply-To: <20260622135659.ff84ef3b831a464b802d7c33@kernel.org>

--7b6316f8522944311de09e5d73742062942bd0c5333c4e262c75ae63769c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Masami,

On Mon Jun 22, 2026 at 6:56 AM CEST, Masami Hiramatsu wrote:
> On Wed, 10 Jun 2026 11:20:24 +0200
> "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
>
>> Hi Masami,
>>=20
>> On Wed Jun 10, 2026 at 10:17 AM CEST, Masami Hiramatsu wrote:
>> > Hi Markus,
>> >
>> > Thanks for ping me.
>> >
>> > On Tue, 28 Apr 2026 10:30:29 +0200
>> > "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote=
:
>> >
>> >> fp pointer and unsigned long have the same size on all relevant
>> >> architectures that build Linux. Furthermore this struct is only used =
in
>> >> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which =
is
>> >> set only for 64bit architectures (apart from LoongArch).
>> >>=20
>> >> Both fields are aligned on these architectures so the struct with
>> >> __packed and without it are the same.
>> >>=20
>> >> Remove the __packed as it is unnecessary.
>> >>=20
>> >> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer=
")
>> >
>> > NOTE: This is not a Fix, but just cleanup or minor update. Or, you hav=
e
>> > any problem with this __packed attribute?
>>=20
>> Thanks, yes it is not fixing a bug, I can remove this.
>>=20
>> >
>> > Unless there is no problem (or any concern), I would like to keep this
>> > as it is.
>>=20
>> There is currently no problem with __packed in the upstream kernel. I
>> just thought this would be a good cleanup to remove the unnecessary
>> attribute. I am working on CHERI architectures where pointers have
>> capabilities. __packed breaks these capability tags and therefore
>> doesn't work on CHERI. When looking into why this struct has a __packed
>> attribute I didn't see a reason, so I thought this would be a good patch
>> for upstream as well even though CHERI is not yet relevant for upstream
>> linux.
>
> Hi Markus,
>
> Ah, OK. CHERI makes pointers to non-long value. Are you sure
> removing __packed makes fprobe working with CHERI? If so,
> please describe it. Then I can pick it.

Sorry for the late response.

No, this patch alone doesn't make fprobe work with CHERI. __packed is
problematic for CHERI because it sets the alignment to 1 which forces
the compiler to do unaligned access operations even if the
struct/pointer is aligned. Unaligned operations do not keep the CHERI
capabilities. Without __packed the compiler knows everything is aligned
and can use aligned operations and keep the CHERI capabilities. CHERI
hardware does not support unaligned pointer capability access.

On its own it doesn't help CHERI, there are more patches that are more
CHERI specific that are needed for fprobe to work on CHERI. I just
thought it would be a great standalone patch for upstream.

Best
Markus

--7b6316f8522944311de09e5d73742062942bd0c5333c4e262c75ae63769c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCak+OyBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP8
cgD+PFHUzLLcRfDxLVcBPU7RyfM5pEeEBxiXn6W3NKuzwAABALAUie9vi/QnT+Tu
kHG9gqcK3fTnbDtREAVtfYJJFCQH
=pAwt
-----END PGP SIGNATURE-----

--7b6316f8522944311de09e5d73742062942bd0c5333c4e262c75ae63769c--
