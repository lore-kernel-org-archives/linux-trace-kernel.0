Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876C155725
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173049; cv=none; b=qkbaFUqFWSxN3U0QM6I9gzTr+5gEmBJTojw8ccw7tjbh++gSPmRG6Utg3R5Dg9ftApGOR8XTTlhbKnuc0Zi1xIobTMrXoot8MNhDBbXGcGCntm5QX2RUkuwTI/TNZw6eDS76tvEv1yiHHP2WmasJRKjgxHjNhbN1AAWIr3LNedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173049; c=relaxed/simple;
	bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEVEJ2v5KDYP7SjYtcuOamppZ1EhfJ96GFAj3uMaDXlYifiH9Bp0CndNvUpIr0hfrPAKnKb2DQLtm3ysNGi3WgqSpF/ujPX4idPZLi3ktBwwx/+AaIlJgBF3oU09609nzMLd3Fwuce3cU8BullfKuVA/y4U0POkn8Zc/EfiYoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmqixFoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmqixFoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753173045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
	b=RmqixFoEt5RMZgG0Bo9Ge3R1AeAa9Vu4+QorFand4s8V6TiUfcK71Hnk0Hi//IW5vtJPlc
	Mrn594gJw+ZnmOXF6aY1PHO3W2jRb1ESYKD1nUI4Cs2EWAVB1GhZv8j7p08J17r7+MuZ9d
	huik5ixR8lT15wkN7Tz3YhK/uyZcVp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-4SfkXrnMN4qzj3ErlW60wA-1; Tue, 22 Jul 2025 04:30:43 -0400
X-MC-Unique: 4SfkXrnMN4qzj3ErlW60wA-1
X-Mimecast-MFC-AGG-ID: 4SfkXrnMN4qzj3ErlW60wA_1753173043
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso53278315e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173042; x=1753777842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
        b=q4TZ42cMAC2yhRqItU6zoaZ/nVNzQRPEiJ8o0O2fsIWvopLFJ3oisH3cfjs5Plb+FX
         TER1wkN/wosSotXhF+B3ANsSXZtZ9GJJwJ/n5KCbbl2+bBUuogbKU9vNIXlKlehZDK2S
         eSGA88kJaZ2gZtzcpc+nSJf55YdyNrQhAO2L9XYFzpAP0oe7APa5tnSwgTkb54jNeFnb
         9JIUCV5Z1QD83jXIDQjsET6r3XnQU08tcOGblRrcPRHoD37SIg+TFIXgKvvAWMmChsXE
         3+/O8v4wHH7lA0EEXENl/LmtWKpuyBNHbhSQMwsCpUutX7cZ8J9qbmO0aYRSUnmSrTWH
         xJHg==
X-Forwarded-Encrypted: i=1; AJvYcCX+GmIJFjS2L0gHiHaNRc83WcBz65IFYgKVjCZGwPxyRJHZp0SccAb+m/cdJbUGRBXxofcoCN+KkQHgu7v2f82JUQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4//7pOqHaEXJNz3hUeaYi3/nSedDOLEcJzUIgjBJGbJdPlpHz
	Jph7xXAnG9qMfwhxQLAqiAkxddG7af7HKq7OJx1xW1Y5i3bC63uIVam4OIGLC67KShCClXqfUYl
	dfDmlF/P+gSX3ZFcHgmrac0b2O8xIxv1BFz0BPt4743ENyiyr4fRnCrDP6RMUtu7SrHGpv24RUw
	==
X-Gm-Gg: ASbGncvQYbqh7CsSOvnn5fV26iAfFAmTj/s0XNmMXaDliU/7jvbR4GgukLfc4lEFYUD
	hceAUDhNTj2Yn4A3rHPR0QP2KAE9BG5q3xMmHyaJZ6OILp+P2bKJD0fG85DIQyfa/shax81bF7J
	3PT1xOuodtcGyAi0S11V/m+Sg5RjlVm7geVa3/I1i8aRoPerBo/m9fLcH5sBMVkLV8+VFotBl62
	uWDqdxorzM170HHI6hG6Qv0AUnMh/lkj3P9JKp5N0jUAfElDJxm4el7UXpo1OplvfWkSPU/ts/L
	LD3c6ip0heNSs8rIJykBeoe7rhs3ZO1Vf4WzCuhONR/AxzIe2UKjwQWnLVFzNHUYiw==
X-Received: by 2002:a05:600c:4709:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-4562e379f80mr220963325e9.3.1753173042408;
        Tue, 22 Jul 2025 01:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGWUbHXE64+JIbc1psRBua8Ih3NqnkWKbU691zIYC/x16+2NNJqu/u4RN+P0cSm668Iu0SmQ==
X-Received: by 2002:a05:600c:4709:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-4562e379f80mr220963015e9.3.1753173041968;
        Tue, 22 Jul 2025 01:30:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm182592635e9.12.2025.07.22.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:30:41 -0700 (PDT)
Message-ID: <0e05cce85c4f2c44123a52bd909a555d98fda8a5.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 10:30:39 +0200
In-Reply-To: <20250722082740.a0kYzRv_@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
	 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
	 <20250721140425.OeD16I4D@linutronix.de>
	 <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>
	 <20250722082740.a0kYzRv_@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 9eAFyZqJ6S5T6P45uKhHc_XTqp0s_uRLWg0yn3TWMPo_1753173043
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-07-22 at 10:27 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 05:49:02PM +0200, Gabriele Monaco wrote:
>=20
> > Also, I'd need to verify this but depending on the order of exit
> > functions, we might be seeing the same problems with built-in
> > reactors when active on shutdown. I'm going to play a bit with this
> > and see if this workaround of not deleting the reactor was
> > introduced for that (I doubt though).
>=20
> I'm not sure I follow. exit functions are never called for built-in
> reactors. They are even discarded out of the built image.
>=20

You're right, was tripping, ignore what I just said..

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

