Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478EA37AA78
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564844; cv=none; b=J7w2ftgU//einBt6du6987vJuScIhcfmn6uQJ36OFY78Etsi2+Jl0ToCKSY+K2SDplpwNAzw2zK6pi2ocNW3tRfkhJ12HBUCoy4ZVQH/YQCBSfjVdjdG/oVqUuEcQ2QjMO93YinWzdP5rUdch9avuAyd0Fff8a9of6QSmx97mvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564844; c=relaxed/simple;
	bh=Ez7++x6Bs0exrn0n9e59sy5TlkUL9gaUMT4RkGtCat8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Kyz4z+XM2Z9pIrJjPYun33EvSe1I4JEST4AA9P18c06dJdpAV5X4YyvGWEx1MBL4C2YhelNZWIM+lwUMJnWiSo/soGQLxLbZkNBkA7kOA4rzKOGKYcKDWo/9sgUCKVv17ZsqPpX8Qoplriu6gBRXqSfi0tNE77i7E7ijAtdHcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMzrs0Fs; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMzrs0Fs"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1094168a34.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788564842; x=1789169642; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ez7++x6Bs0exrn0n9e59sy5TlkUL9gaUMT4RkGtCat8=;
        b=FMzrs0FsukxowoPhFJ1vs8tO3LtgDq6p84oHyZFLufj7c/je5fIlfzEAEiVtySTpm2
         JHiJiCvoXJsIPwSfhSaw+VG7HVRe7i12LUD8FK2uWtmeoP99poGBqg91iYWyTQGsuTvl
         XAkwC36y2s/HmiBAcLkbkF8/PdfWVd2uexpUO3j/RYYMaDxfAY5O6iSkccUv0cJdSa1l
         qTJbubHFvVWOL6CJUQfY8Q5lSPui8wjqffUCg+/xvXZ/UxME9mOwPOY+jAAgmYtPUI4L
         FNCGogNyYad8v28VSHrkJS3Us9g22XXhMcZ6vD7GTZgyHYvnDvJ0phgolYDK12J+2Db0
         Yoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788564842; x=1789169642;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ez7++x6Bs0exrn0n9e59sy5TlkUL9gaUMT4RkGtCat8=;
        b=BW3AzhoOmeDmlruamDDU+EDgfbwJ4fGL5J7+DjL+Ijs6Wo1tfoQ8VCY9vhMeagooVb
         mNYVaXRV9fORBnWbvV/U7Gb7Bx+vSVX8/xcRQhQqn+3EqwZjtpPhMZgWHm6faz7MLr2K
         TLE4+Lh53tzod6PT8h2OGZQIJe6SXBtVMQtPeGIcae8PLu53T+rmik9NVHV9dVIAXDCV
         GVlS76XpqOovIvhzQ7kC+a1fKinYIJisrTPVcykstbiFPEPG8RwCGJSm5GApp1aZypGo
         W3/DECcAJikQuR8pAo802rdfPBZxMogebAbhtmONauuI1nmkALO2s7aLKfQRYvDs57o8
         8F8w==
X-Forwarded-Encrypted: i=1; AKwUvBwZXpXaZzd1mNvYI2g6gaFRdlIjEuHbBTTiTX8RvGF9sNYEq6gXc6i1w/mhUedrhJ9knwUQnmyiJYpElN+ZsME3tgo=@vger.kernel.org
X-Gm-Message-State: AFuF++lMCZqJQKQOk9StSW3ysFUk0B0ByytGVP1nxaHYICKwRMZabfHL
	uYe7yKf6O3WAo9ryAC5BomJqxe0onem20ymv3gxwBbocNaERUpVwLH4l
X-Gm-Gg: AYBFou2l2X5jUen+D12U5puR2TILqMqGHCr2KzD9CL466QwC+sp22MO9/ehMQIjfoV5
	1snMUsDp9F8ADT9sp3NVbxq+Ln8B9d887mkKlmsE4KdFQAZmXtu9rViHqxWkcS6Qw80KUWM6M/v
	/BF9ruCKp7zpJJWd8is1M2SHlruq0EKf7KJteBcZc8gOg7awKPH1Ci4znUWOx8IVo31HosdvLq/
	yb18bWVuYHXQk58MzFNKNMLjRkFUeqCfIZ7COEUGfEmFrk67IDiPOLJypLbGQvYWDTvygN9PhhC
	8AFfaGmDY18mk8jibuNkLhNv/x9fULHh47C2axNJQwzptaBmsaPeCEZAd+/kFMXDRniIRIQH5Kz
	4JFValtDFe8/Vj+YFBEVExeppdZJMrcsJlbhwfn8hdVvVdZkHKmmo60pxJdsU7uxI7a+nNaTswz
	RrC/qH7rRxWks5BwWO0ayEGmCZrUiQGoE6LovuuAlucNjxLDkhk1S1vrznwsoz/yM8c9jODWT8L
	FacaqxT2Se7azuLSEq0SAWMLUmbQFJphcIdSOLv7OlH7mqZJzKHnQ==
X-Received: by 2002:a9d:7654:0:b0:7fa:5c68:d053 with SMTP id 46e09a7af769-7fa5c68d6f8mr3561333a34.29.1788564842051;
        Fri, 04 Sep 2026 16:34:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7adfce8sm4355756a34.24.2026.09.04.16.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 16:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 16:34:00 -0700
Message-Id: <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
Cc: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
X-Mailer: aerc
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home>
 <20260904132421.111c0279@gandalf.local.home>
In-Reply-To: <20260904132421.111c0279@gandalf.local.home>

On Fri Sep 4, 2026 at 10:24 AM PDT, Steven Rostedt wrote:
> On Fri, 4 Sep 2026 12:31:08 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> In the beginning, Daniel Bristot looked into doing this with BPF and fou=
nd
>> issues with it. I do not recall what they were and unfortunately Daniel =
is
>> no longer around to explain it. Maybe Gabriele knows what they were.
>
> IIRC, Daniel even told me there was a competing effort within Red Hat to
> implement the same functionality using only BPF. That effort never
> materialized and everything went toward the RV code Daniel was working on=
.

bpf in 2022 was surely less capable then it is today.
It took us 2 years of bpf core development to statisfy sched-ext demands
and we're still adding new features for sched-ext needs.
If you're trully willing to remove 90% of kernel/trace/rv/ and refactor
it into tiny shim where all of the core pieces are bpf driven we can
certainly work together (like we did with sched-ext) and add whatever
is missing on bpf side. Then all existing monitors will become bpf programs=
.
But adding bpf as another 'monitor', sorry but hard NO.
If hardcoded monitors was a mistake then admit it and fix it by deleting it=
,
if it's not a mistake then keep adding hardcoded monitors.
