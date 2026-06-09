Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5677408608
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008762; cv=none; b=rl2feuzZuZ3Y3YwKUDnhGwnbABpdB3kziq6Ks556QhQPqghqVO41nGeAOZiNq4AcSggNDSarTV5jvij5QBzukcsv4bVPnVO6N0CUwtstS4TJhROniDzxeRY2tdNPLMNbHmRJ6Ri8LYNp37JIZEZF6vUJjPhIcTzI/GkOMgzLFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008762; c=relaxed/simple;
	bh=uzmarCe4XTY8E2ARGmW6Wi4BS5LtexkBsDruj0PTMj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOt4DZGvDUu2fn+IrhVO5cWntHkTWW1Ss22SzfTGJmJp4w+SxegTZLq7JohR/VbzsCXwk2NTBIM7oWjM1Jg/ABRGw3K03v8+bDIrhSDU5Vgo+1Az9+fYZ9JUfx9nyubq68xWkuXv63thsgV8JiwuW/oeASjQndDbKc5HBekRkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXZjT0eL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXZjT0eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781008760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CMayqFcy6bn6oa/uOvParTwIAVjEw6ftY4OO10cCak=;
	b=iXZjT0eLHEKMH/PsNSWUk1MGe4r0xId9w8U/Oa7Yl9W90BpaVMZrxwEU71OMQhjXPG8x4S
	w0sE8o7mhtqGaOxlyDkslA3wQDdjvIY8JjqS+5ZRAajzje7Nljo8zZ9PHV+R8U9meUFW/n
	fCRsuUAobvrXs859XPVJ+u3k/UBQgEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-AMH94XbpO4qiN4WUD5xIfQ-1; Tue, 09 Jun 2026 08:39:19 -0400
X-MC-Unique: AMH94XbpO4qiN4WUD5xIfQ-1
X-Mimecast-MFC-AGG-ID: AMH94XbpO4qiN4WUD5xIfQ_1781008758
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae4d89e2so55200005e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 05:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008758; x=1781613558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CMayqFcy6bn6oa/uOvParTwIAVjEw6ftY4OO10cCak=;
        b=DzbEezkUv1PEvtzBcfi6Iq6ngh+BWyLFGLuimCxrcQ5CAfKRPMOCkJRF0vBA82COlX
         AHTTeVganYmhhvB9GJHiGw8vUiZH9aXxZrp4Qfr/y9UWmfU056gvcRIgjcSm9fc7gmTm
         LD4Pt6HMgzwh8vgLg12zbgTe4HAVd4vlyrIruIuzPsWq4wmr/fnQZVsnVlgQZlZdjT/K
         GzTbbyP1/qhAGOlg5gZPji1YsecfwhsCs6AWed9AZ4XYvmwwVGzJ6PfKxdypNhJnwVVv
         HTl0cJrR2BeKjA6CgsDf3lTW/X+mbTjW3iILv7YpmZsGoAKJFyUpAfAv1aNqJWB+Kpu2
         7lew==
X-Forwarded-Encrypted: i=1; AFNElJ8Ug6KQnJ4KMiNdQSRYPYtQMH6uwkbQdlnG32dBK93Xp7/MJxUFHjYu0/9+8ldtINngqBRiaDIVmO17hx34G4OD8wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuqMk4KpVBN9LAW6IMoAZHdn78yR9hqVExFSnB46YPNQZehzM
	XtGctPKgJtAFsWFybk+piEquu0DfZyCDEUnPK7a9c0KYKFfNBZPxUCrPCqzQyOdBZvVuieSoqIg
	7ogDRHBTx6/T5EKHDyG2uoWhetl81LuUzWBNv+8tKZDcj/k0LIJpitQkLeTPd5TP9TWE3wJcNwQ
	==
X-Gm-Gg: Acq92OHlqr1jfFaHfFaFmX0nUn626TGjBQXAc8M/Uv4prLBQH6L05UIHLFuazZacsWv
	N1UcalPwXmQp0qv6hbtFY/+Z3UekNeUjRoLcGZ5dDf31ULNCx8s2W5sw1gglu2BmY+R5IwOhVQe
	RDMV4P8HpdtD9YP9nNtUvMtjKTZXkMJtoJio8o93V/Tku0PXXsXqiSxtm/KqXnkrAydooUqRhrq
	ehcfJkPlFSY/aXOS3oU7M0W7TdTHjulWNNucU7pr6TrRXKkDJ1hdugJogBnGS8nsGBSWBOvxh4Z
	ItvzlF34ElTP6dzKYA0cvN0ycxiNlr8CFT+OhwDdx/TKcv7KMvSlJOxoF8upp4x6JFxgQnvz1Ma
	SJkUq3P8AKqJzyex2F7Gzp5bpZc7IVXIm42wY
X-Received: by 2002:a05:600c:528c:b0:490:cdb2:fb5e with SMTP id 5b1f17b1804b1-490cdb2fd19mr160784425e9.22.1781008758216;
        Tue, 09 Jun 2026 05:39:18 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:490:cdb2:fb5e with SMTP id 5b1f17b1804b1-490cdb2fd19mr160784015e9.22.1781008757834;
        Tue, 09 Jun 2026 05:39:17 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm66272108f8f.36.2026.06.09.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:39:17 -0700 (PDT)
Message-ID: <ded9af4b0cdde4696c0a295e0c622a9d39c445ee.camel@redhat.com>
Subject: Re: [PATCH v3 05/13] verification/rvgen: Convert
 __fill_setup_invariants_func() to Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 14:39:16 +0200
In-Reply-To: <e5f62eab0210df74ba5dea5c99e218b39d331274.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
	 <e5f62eab0210df74ba5dea5c99e218b39d331274.1780908661.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dj07BbjOD6F6yIeZ3F9cRrugRPXnEBe1Qe9S9P7Y1FU_1781008758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 10:57 +0200, Nam Cao wrote:
> +=C2=A0=C2=A0=C2=A0 def __parse_invariant(self, inv):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # by default assume the timer=
 has ns expiration
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_type =3D "ns"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if inv.unit =3D=3D "j":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock=
_type =3D "jiffy"
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env =3D inv.env + self.enum_s=
uffix
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D inv.val.replace("()",=
 "(ha_mon)")
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match inv.unit:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
"us":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 val *=3D 10**3
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
"ms":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 val *=3D 10**6
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
"s":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 val *=3D 10**9
> +

I need to add a test case for this.. You can check by using something like =
5 us
in stall.dot in place of threshold_jiffies.

val is a string, doing val * 1000 repeats the string 1000 times in python!
We need to convert it like we do in __adjust_value(). Something like:

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index a080b92334..4d39f229c9 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -244,7 +244,11 @@ class ha2k(dot2k):
             clock_type =3D "jiffy"
=20
         env =3D inv.env + self.enum_suffix
-        val =3D inv.val.replace("()", "(ha_mon)")
+        try:
+            val =3D int(inv.val)
+        except ValueError:
+            # it's a constant, a parameter or a function
+            val =3D inv.val.replace("()", "(ha_mon)")
=20
         match inv.unit:
             case "us":

Thanks,
Gabriele

