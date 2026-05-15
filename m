Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483A49550E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858708; cv=pass; b=IE7haBsoMT8oZEyJnqn5UMGr9qh/CiL7zHYeWbUJMeml+x2hyHc65BwiHjInMXQcqvfbkQi6U49Koec5sWYMsNi81IxXQBzOi6dguXA3gRp+Yj28jxYByqATvlTCuQLeNlE2/kN39QEnTHSabm4+Ta4CqHCctlEaxfVMze9e62Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858708; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LBWTKLuTiYZNI/KkLUnJ/qHrBkOnL8mShm7YXDNVJZp1Rujcxwuxaj0b74bph6m0KBP0QrhAFuP/Mqns3F+m8gAL8o0QKWVEHfaGQUBjZ6pK+NYgSdOAxmtPPd2GYtkvO6NUjmCeZFwTgcO4mjuS+K3GajLkYtZb622I/FmUqK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/QTQHmk; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/QTQHmk"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso2240723a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 08:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778858705; cv=none;
        d=google.com; s=arc-20240605;
        b=ACyv6aD0P0c2mmw6hxREqJJmcqK5NDyYfE5LzAR41U+gw9YLy5CO4COiouT6ynKeJo
         ZjIZkl+9Jj3+mVi9tJf30BT35QvriXyqNdwfo+5A3534NyzQivD6U9zK2EA9OZ5Pq02k
         FfTP0JthorTnkaqd0PsYqinTxNXn56TT0eg9lULVlphJgLRT4vYAhIWqWfGm3e1BmV6V
         ey5o92Vbj4Rx50p9FQEBXW/wwA8EZ7tXzav5qdrp7jEkPfFkP7d+dt2S2a7oJe4Nyx7I
         gzxFiEfaUuAxygHoZfdwrUid5GGj4V1VoxGwv5eraabydVeQnE7NyDpDNlQqe98Ds2oR
         H9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        fh=ctVcqGxpoBTc6wVR4MrXGKGyP273TLOv1r1Ou813hyY=;
        b=M3wFfkawnxR/5gBJfTuEhyy1Wwgpz+eRH0PmrkMp05SMlrg4vq7GJ7uLLWt4l31qwF
         fY9ZYTwu3+86uVdQvqUBIc35VJCGwgwdtN6W3elVShLNkm4OBpbHKaF82bMI8Hs9qw28
         A7HZ2Lf/cBFV3liB0DjZNON5f9+ssIleg4MpSsDhla03rfHf77vChP/+4mnm6ytL4pxi
         jEUCPHX06g+Mbv+MYHkdo9OpsyznfpAc20j/h6A2IMzXVM0J9gI9q/+R3co1+1bTqLEJ
         Kkyut2T4IHB+P3uNUBbGyipECEc7Lv2E1g0AEAifu5baftc2rcohMUdotQptaPufxEcn
         5tCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858705; x=1779463505; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=Z/QTQHmkk2R6tr0g3oii8CCg8t01+15XJ59uTt74xRKUxtXli6gpMybU+3RjBqN2T3
         fMl2iXPfO1x6URSoOlxZP5znYcblg2PAJzRhQOq2e24mspVjEGMMO1FzLSLugYc+MwjN
         ePVgLqBRQbq5KVirjXl8le96pFTSN0+3+DXLjEjzHznM0anqSTQXmReClLsYrdWREbt4
         p12MqLNi2s4NkgK6JflWbc8KHxKiwDNzNFlQdnmkKALOnPeY8dVfOG6NyM1DOBEpuUK9
         1T2NOtHSjKmtr2g3bGwnSumGDCTL9HGPAZBQm13xNTvm/RFLpWoRUHJ68uRQ8FpP0CKS
         YgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858705; x=1779463505;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=hI7rTO0ouJqzTxENhbae1LCrM5/LWXei+feHrvi+ot3pq/utP4fXIXHo09EogC30rv
         78A3oysJzogmiS4w50PVU5dgiuFoNfmcIQQFxJI1XPOgzVtrZcAjG5ypUaxG5yfQGERb
         PG/NLxGgO6T6793DPv6T5lbnMef8FNFZEYo28Qj8ieBeZSqRzF2zmybflCMSU4xiovd/
         fvfXH7vqbvWdaf/8ME6tw+XNvdry2ye0aq/B1zQoszV0c+43dngOX8l8vPbtjXq8BZ0q
         jv2bfIcts/EqKFoG/PgTVgNTS02ufSF5g5+fnZtDsYhkbZHLQLb7vc1uONxu/kmurn0k
         RLig==
X-Gm-Message-State: AOJu0YzKFHfHqorDiO433A4462Ac6sB7mg+jEtA+yWvftkbhgYZCdM2T
	d5TPxtWP0o3HvBTM1t8QCIaTlaGTaEEX4r78fZ3DD/EvqPZGgIoHmMqF1y/j2bQjG21uFJEHgfN
	7mNLvhhd6fbBlvvDnwca2H+mu0OIDMHedk9eJSFZnpw==
X-Gm-Gg: Acq92OH9qdiyQ363YrODeHltcvBWLq5131F2L8cblGqPv/POfvqRK77e1OEgyCwWkIn
	SPfzt0sA8Zr+g1VZaV0Nx4oP7s24JhDK6HKw2LzfgqDi0ra/tni6UhnM/osHO5DPcoSk3l792ts
	PKM4TghnYCFVMprJ1xjxhaCDX700cIa9VcGwyGGrSA6CPFcNOTkblYqIcCY2ZrSQ4tf8a3/AdRf
	nAho6cGyzFhGjWi/tTe3m/XKknicVz5sYKqNjX4ILsFhyr76Tka6A1qwkZh/+Unj5iJ6M8TisR8
	8S/UM+t3RRCId1oF0YstcwKI1Os=
X-Received: by 2002:a17:907:7248:b0:bd5:2a44:6f29 with SMTP id
 a640c23a62f3a-bd52a4472bcmr93685866b.7.1778858704355; Fri, 15 May 2026
 08:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: IM AgentX <imagent4bd@gmail.com>
Date: Fri, 15 May 2026 23:24:52 +0800
X-Gm-Features: AVHnY4LEnlGwSlFHlsaso-N6vWOeWpaFCyjnJtt3hlcwiqbV3qqdGtK_Bv6ePJw
Message-ID: <CANUqUTWvv4jTY+QE0ExR5h51ga5FuM2EmwdjB6YF7upzNwuHNw@mail.gmail.com>
Subject: 
To: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe
