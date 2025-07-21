Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054022BE02C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111045; cv=none; b=LtN1jksZElasubSQu2E+vy0hX6zWWOzuPIb19JJdFn88LwIJJuDSpuXYRNtA8nx9c8zlx35mLbteNRqw0vJNOE8jJU51FndkMr8zeplkI+VC8LMdbT3aygzzZnzWKpKY/yMJchu/EuIMQ86dgACjomxlnxaspXYNx8PxbwMFQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111045; c=relaxed/simple;
	bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tq1Qx12s0SIbP/doqni/bvcR/vxuj7NXQ5RfmhesFFP4OjTfRrWJCJQ1uH7sLJP2TwzY2HY+xwakHfT08W3xLeOW7RYLZzdkqd0DHGWDzsv7KuXlTZOb+BuczvuHcwO8Y4XIFRCscs5O/DJx6u1nkppNtZT5vSkqMtXwWJV38Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqeQj11c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqeQj11c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
	b=FqeQj11c03Z/qtmXnnm//xLU1EoT8HQpWp/DXJrvOFZNSXO2+RFgZ1JFsV6aUnIM2p2zQs
	/N8osW3+PDBvg8MiAdarUo+cQRTCqx3e5qReTNxhijdcfQyo9j0l2x71urSrFfIks3uEpN
	mrWt4l/Q5LNDcrcmbY50wIDDtHImYaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-evK-CGmFOQSW8mAh_gjElA-1; Mon, 21 Jul 2025 11:17:21 -0400
X-MC-Unique: evK-CGmFOQSW8mAh_gjElA-1
X-Mimecast-MFC-AGG-ID: evK-CGmFOQSW8mAh_gjElA_1753111041
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso46092875e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111040; x=1753715840;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
        b=eqCfidd9lggoY79dNOskiqPRFkoxrc2AwrmYGCIyZ+Mot//mKWbvYLgID70LPE6uYi
         FhIJOub4wlBcQasp2SEF5vuHwN1cY/nohMnJQK9mgh7lcJo2IkPT+zNDwZLEF+CICxHn
         I9IlBNWFZ3cG+PT7GfR15RoekJtfDgEHD5eYNUxRG33Nv/RUKUw3vUg+rkzgkAq+72bG
         txzbULr9ihiikfX7xHq1clV0ZHe7YAXUkyL0Be6BoEz9iZBi2yu60U2Qqc3PsEQdLozk
         ytyUcDSi1J7KtA9LUyfpCp8u1ojy25Jg89fW9AO354QuXRsMd2SOdY+6RZoNUiklQ7+R
         I9hA==
X-Forwarded-Encrypted: i=1; AJvYcCULmqoTT8luNJHbwIXxDi/WkfWfpoKRdA/AOvof1a5bBdIeuevwGS1lKyGp1mNraJa45VLizFEaXouzUIXdrziHda8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLSmsr1Hi2y+d1f01HH4MnxH8urDwJeYs4hAp0qzOFj1CUXys
	Ga6RNi0UaMb5Vif+maXRHTJuSoIcwLNxTum2hgX0QTxCCiu/tcB1Qyucx3DZfzZx2RJfu/U43hF
	0+JjU0VZ8E1SSwUt3ga6i5VOpGZnQ389dmLr4NLBfuRWWNJ3B4U6IWK/XlJ5en7hEnHZu41+TIg
	==
X-Gm-Gg: ASbGnctuvq83XE9aQ8x6vhw0LqBD6fby8L8gzerd7myTHCTwfLSBN/oc/kHc7JbkJf2
	RByAzApxcKqDx0MeY/72Bp9KFAXjXnhdtHElOk77T1jRZU88+ZH1BNtQ/lF+clM+IyXXEaBAXzS
	rsfTGxOUN0bLCvKe6hmS2DHdgMhoT7YtFA9zZtmdFIjwhdpAiaKrtB/QrX5NZWOytXTU7k7wGss
	riw5Hg4GVALxxUS3xszf5yXYwOa6r3uSg3llIVo+O6wRP94kKvXeyFHObNdMkRZLXnuXOqrNxrd
	BEA3GUqiETxNjl5LBTwPTAJBXcXTIwfnVPzvaALEdNjvMbqFxSomztm/Z+i6VlHFdQ==
X-Received: by 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr161756175e9.7.1753111040480;
        Mon, 21 Jul 2025 08:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0awfMQ1BLm9hV3QJO3Xy4wzwk/kIIZ2C8+KN2Vjm5PmNJzgT2V/sA1FHtGbF+Op2uKJWykA==
X-Received: by 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr161755925e9.7.1753111040048;
        Mon, 21 Jul 2025 08:17:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b762bb4f6csm314827f8f.4.2025.07.21.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:17:19 -0700 (PDT)
Message-ID: <85876b4f36c4230c0be34fb0b95f539179dcd445.camel@redhat.com>
Subject: Re: [PATCH v4 08/14] verification/rvgen: Organise Kconfig entries
 for nested monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 17:17:17 +0200
In-Reply-To: <20250721143814.waTN9e5C@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-9-gmonaco@redhat.com>
	 <20250721143814.waTN9e5C@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g2R-bctKL0qkkPRB6eAhFzBV9dpCjsrctLBreaMfd7o_1753111041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 16:38 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:18AM +0200, Gabriele Monaco wrote:
> > The current behaviour of rvgen when running with the -a option is
> > to append the necessary lines at the end of the configuration for
> > Kconfig, Makefile and tracepoints.
> >=20
> > Adapt rvgen to look for a different marker for nested monitors in
> > the
> > Kconfig file and append the line right after the last sibling,
> > instead
> > of the last monitor.
> > Also add the marker when creating a new parent monitor.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Some nitpicks below. But regardless:
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20
> > -=C2=A0=C2=A0=C2=A0 def __patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0 def _patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(self.auto_patch)
>=20
> Nit: follows PEP8 unless there is a reason not to: assert
> self.auto_patch

Well, all the python best practices I follow are the ones reported by
pylint, I guess I need to configure it to follow those.
Thanks for pointing that out!

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_to_patch =3D os.p=
ath.join(self.rv_dir, file)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D self._read=
_file(file_to_patch)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D content.re=
place(marker, line + "\n" + marker)
> > @@ -146,7 +147,7 @@ class RVGenerator:
> > =C2=A0=C2=A0=C2=A0=C2=A0 def fill_tracepoint_tooltip(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_class_type =3D=
 self.fill_monitor_class_type()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.__patch_file("rv_trace.h",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("rv_trace.h",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "// Add new monitors based on
> > CONFIG_%s here" % monitor_class_type,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "#include <monitors/%s/%s_trace.h>" %
> > (self.name, self.name))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return "=C2=A0 - Patching %s/rv_trace.h, double check the
> > result" % self.rv_dir
> > @@ -156,10 +157,15 @@ Add this line where other tracepoints are
> > included and %s is defined:
> > =C2=A0#include <monitors/%s/%s_trace.h>
> > =C2=A0""" % (self.rv_dir, monitor_class_type, self.name, self.name)
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 def _container_marker(self, container =3D None) -> =
str:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "# Add new %smonitor=
s here" % (container + " "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if container else
> > "")
>=20
> PEP8: container=3DNone
>=20
> And this function name is misleading, it is not marker for only
> containers.
> Perhaps _kconfig_marker() is more appropriate.

Good point.

Thanks,
Gabriele

