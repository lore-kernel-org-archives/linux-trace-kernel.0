Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB105270540
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875956; cv=none; b=i1OqJ9lEwitzCOxT8Ikka9bbs15VyFxZlWFTuwULpvId8DtBtQmyp1GX9xV96OukFLGO1295dNxhj91QocKXZgMyCSj29TZk6DSKq5xD4RmDdIK/gKzLISwrsb0ZjUNmiyZZd2tAuj+8wKbtxylDnywdXlsQQyNWiZ2kMEPNUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875956; c=relaxed/simple;
	bh=RkhnrmCQn+C8IUKYL+s0NyQgQiW+yLA2LBJb5dIfL8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hC/jg0WpZsSks9waHGnAsfUiaXEwsDSV+CK4Bw5X8cy022zDUmORPxwl6p8xyGV8+SFuldK3I2RQ6CZZPu3tycGiNfMRsMRts2vIp8IUtQzutHG/TDNv7Py/R14UJwwSMbrRoqBKSIqgM2x1GFeSd2aXP8RjVAqICUrJJZ3o5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhqWynOa; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhqWynOa"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b220ddc189so588552985a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765875954; x=1766480754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omqi83Dx+x81K7T7juSYrVfh9uoVtgWx0kBcmziIq4E=;
        b=NhqWynOaW6iqxvykkhltH1Oyk/0m6Xx+yqSxxOBiwKHk1QdC9Avc3wdUOmY23xQfVg
         Od8FAZZdfDpjD5fwyTYuoXQUJ/WgaKaylAa/EJ46ivciMiWzXt9aqmJ9/op+qteGq2AT
         6gRaYIYk6n74Dzn8pfkpzFmZ/aBR3x+StoN7ovtYODQzUZfKgQ7bOq6lBVBOjxlnpOhA
         nWBjyFYjq3CSUuVQWx7FsDhOCUO6KTe0wy6eiGlOTq0olMempDi+PRdl3PX8EwOu7k/p
         fPY8cfP+CUM2NHYmlCJT+FADoHzY5++2xSJYfLgl43d1HfztI/NdvY5xQl4xXqbsN28y
         TuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765875954; x=1766480754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omqi83Dx+x81K7T7juSYrVfh9uoVtgWx0kBcmziIq4E=;
        b=pumhOEe835XtHN298sD5NsCOWPAZLRh6AuoIDBV+3RvYmWJ2oQ0EO5wmXh1YdYP55k
         RYX4d3+W4bC2u0S78vM2pbYJqZn2pV+BC/1ALmXVPYKx6FPTrthL3cVHDIJcapxwv6Pi
         TUy4nhtfFF+vE3OBX6Vl4O/RhwBEcLL6UK8cuMXiFDEAyzWSIZGxapuP6Hdz8Gb2gJh5
         EDXYq1RH5DH0tTQ2NauLCY1t0KCxIcDGpDv9i2kZ+mOruLJGU0MjzuHdxtrByKM3N0W4
         n1TOwhCvbPltEr64zu5TCqypw6EwX9cNVrEa8bUaQ1t2ux6KIlRO6nZECaavwhEv1NDO
         yPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzc+3YCxsIFwN472tb4CORJnKhIp1pjiXoDyEgkffWvhXgC+S2eEpTcj77csqp6fZtZN4X16LrWrdwyqX0v9jA3Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHMqvKfMu4k4WOAo+F8NEJMX/+GMjrVMMWEkK2PUi8lkvqrL0
	FH0UbeyZD18f6ucSlGfeQvGnqXYA2uq9X4q3KU728maqC7mNsbhtBnY06IkbanBMiT1aFJVeL9q
	koHZVvZ4wmHWPHwPF9YZZ4oe6Fqe6OQs=
X-Gm-Gg: AY/fxX4lFdP950UySb3OmbO2RiFjdCHDIbdKEFhji7zqqG5BsdRTB7o55zfeF1S2SvB
	omGsXmzojgyG9LLfqWojLf68p3ebGDRfkUKgm8ptdMoyedDUdsLOS7etaZeNDsGJEt9basvhD7n
	Z3Ns50v3dXMw8VV2pSkwzMPzPwZwcwP1Il9dRNXIMnMafrlU/ADFjhHDmMHqKRQXBoYUzOtPMoK
	bu3M7d5MTCaOcEZW8ECnTdmMrSZncNflr/0FUTEbG6ir1nY89ExJ+Z0FiIz7D0Gc0COwQ==
X-Google-Smtp-Source: AGHT+IGtPCRn7o6GpcrQ+8fRciXS7VNEpBZ8Lkf23ew80RNqVMmRb7tCJfaiB2F9T8S4MmAQPN7EoUUC/1k6/pOdU/A=
X-Received: by 2002:a05:622a:5a12:b0:4ee:275c:28db with SMTP id
 d75a77b69052e-4f1d05a92b6mr191064771cf.40.1765875953475; Tue, 16 Dec 2025
 01:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216063952.516364-1-gxxa03070307@gmail.com> <7a41abc8-df47-459a-ab3e-ba7943fdd0ff@amd.com>
In-Reply-To: <7a41abc8-df47-459a-ab3e-ba7943fdd0ff@amd.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Dec 2025 17:05:42 +0800
X-Gm-Features: AQt7F2ow7EPRc4zp2vCM4VRNSdM0megkZw_8cCDJsWlQEr6TXDtd8MO6vKv8G1g
Message-ID: <CAGsJ_4wbKFf68EW9vF7k6W0PPbMbjnc9s=rKBzqOnhfDwC3F8g@mail.gmail.com>
Subject: Re: [PATCH v6] dma-buf: add some tracepoints to debug.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, sumit.semwal@linaro.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, kuba@kernel.org, 
	brauner@kernel.org, akpm@linux-foundation.org, 
	linux-trace-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:44=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12/16/25 07:39, Xiang Gao wrote:
> > From: gaoxiang17 <gaoxiang17@xiaomi.com>
> >
> > Since we can only inspect dmabuf by iterating over process FDs or the
> > dmabuf_list, we need to add our own tracepoints to track its status in
> > real time in production.
> >
> > For example:
> >    binder:3016_1-3102    [006] ...1.   255.126521: dma_buf_export: exp_=
name=3Dqcom,system size=3D12685312 ino=3D2738
> >    binder:3016_1-3102    [006] ...1.   255.126528: dma_buf_fd: exp_name=
=3Dqcom,system size=3D12685312 ino=3D2738 fd=3D8
> >    binder:3016_1-3102    [006] ...1.   255.126642: dma_buf_mmap_interna=
l: exp_name=3Dqcom,system size=3D28672 ino=3D2739
> >      kworker/6:1-86      [006] ...1.   255.127194: dma_buf_put: exp_nam=
e=3Dqcom,system size=3D12685312 ino=3D2738
> >     RenderThread-9293    [006] ...1.   316.618179: dma_buf_get: exp_nam=
e=3Dqcom,system size=3D12771328 ino=3D2762 fd=3D176
> >     RenderThread-9293    [006] ...1.   316.618195: dma_buf_dynamic_atta=
ch: exp_name=3Dqcom,system size=3D12771328 ino=3D2762 attachment:ffffff880a=
18dd00 is_dynamic=3D0 dev_name=3Dkgsl-3d0
> >     RenderThread-9293    [006] ...1.   318.878220: dma_buf_detach: exp_=
name=3Dqcom,system size=3D12771328 ino=3D2762 attachment:ffffff880a18dd00 i=
s_dynamic=3D0 dev_name=3Dkgsl-3d0
> >
> > Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going to push this to drm-misc-next today unless somebody has some last m=
inute objections.

No objection, but I would strongly suggest Xiang include a
diff description next time, after the changelog for each new
version.

I recall clearly commenting on both changelog refinement and
the DMA_BUF_TRACE() macro [1]. It would be better to mention
similar things for each new version next time :-)

[1] https://lore.kernel.org/lkml/CAGsJ_4y0zc_nh2q=3Dw4uR04vtveCf6L7+hgafznH=
uL8ByWbyNOQ@mail.gmail.com/

Thanks
Barry
