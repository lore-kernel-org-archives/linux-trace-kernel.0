Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F81C1F07
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699230; cv=none; b=kSO7vxvLmoeHAlPyQkY1TsfstlPkaBHy+DWB2VE3Pfhn3I9dqxrdkZgYkSFoovZSE7qnq/vWwDfeHBbttdGMQiudFvULIVLC0boY2zjH7DpYaHLi5+J9dEdKM5qYsI+2UuKwwisiP7WhPUCio50JyckFX2J7xzcfV+oIfGtQigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699230; c=relaxed/simple;
	bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q23eUQ3yrsPu/8VdisZZJd5R+pyBgJxQB93kPDDPWsKqPYq6DAb1H0dMUq0/eiyVynSr6d5vjnxpO6zQ1lcXQCIlsYXTTpSsMbWsxkSYYKhNgfLCgK8M8heiFAAl9cjfKMgz4glYk/JYKEYm0Z2+R3HDW45R+C1uE00bBWfLTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZW1xyzL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZW1xyzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741699227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
	b=SZW1xyzLE/24CnVwndDmIDNNcUpevMf+SMFFd+oka8bHHMBZ+UHQxk2MOtzCzG2wuW8vTu
	haKtXBOZB2BuqWzHmTPhsoP1p79ACDF+pSjmEc2k1Z50oYvWqLodiOHxWThXRwnq1wvm8k
	npcGCXCFzDwzBZUIZZcyIX+/k5QmZZo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-JZGks-IlOde5us4OewBAqA-1; Tue, 11 Mar 2025 09:20:25 -0400
X-MC-Unique: JZGks-IlOde5us4OewBAqA-1
X-Mimecast-MFC-AGG-ID: JZGks-IlOde5us4OewBAqA_1741699225
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abf597afe1fso542162966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699224; x=1742304024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
        b=qIT2qWYbAN+WmFhCGUFFttPsORAO4H8tn59arT1CVZLulSOknaPItD9181PPEB1RIZ
         Ra9xCjk8+673X4BieRCxORuOft3psXqMhLEb1RErGjUQN4zty+SSp0r9+nU4uhWMebk+
         o4IHo+89WPz8SdE0/bbYczj7NYlIxsBsPcowJoi8+g4IFZojq6xLNPLTy4HUMro+K5qY
         jdQM49AzqOZoSf8srAkyi47GFUTyq6kc8S9kJQIJh2oXOxGv1G8tYVSD7O2gCBGUVcqn
         QDLljlFr5KTutTka1m3ozOT+JZ7Hwj/tYBd0nSiZv87nbbsXZfAMdmE9YWNCIBj/12gS
         ycsw==
X-Forwarded-Encrypted: i=1; AJvYcCXyNC4rM6CbXVFwLZMTLQHKWHqj0BpTf5mL4nztRb7YPvbh3JgYWAvxuCQNJbNmFeejaZ+XJ1ZbGvroZny9nWxLrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy73bEx6A/z2wSkrLZeNNQZzwqmcn9t0p4aciufxNck/CzdtIh
	jRL70oSAke+vMEz5M+uvGutZW8XD8BrhqX7brljrygdSQRm7lcshTT7deLMAZBZ0MaYOBM+S5pT
	WshF5KDSPeIzfZopgL2m4FUOtVQcn5l3EWNoUSD3HWdcYFJYrm+1QS9ryO/OJ2dpNHAZnvzYGiB
	WA4of9zZXcTn6YBKj6L2/oRAmuqsjJo2xtVNBEz+KGygNb
X-Gm-Gg: ASbGnctPG/KlDfmKklvg3ZYr4+DQWfK0sq1G2Q9mDqOV2XTA+ee4YTVwb9PBeKke04z
	HjdU4mqY8GefRzdMBRh/6Ri1c29buM1lttfR6f4sL4YMjDRnCWbUTvx2FT1JbSoDM5tvyIhEZ
X-Received: by 2002:a17:906:dc8e:b0:abf:67de:2f1f with SMTP id a640c23a62f3a-ac252ba467fmr2029920266b.44.1741699224640;
        Tue, 11 Mar 2025 06:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYnj8F9Jf4SwA5xwmTqfm/NOh+ZyOvFJjWLkViuxqCpeNhUyvZDmEsh7nVvGxJdktqfaid7A4f0abzVZFRF0=
X-Received: by 2002:a17:906:dc8e:b0:abf:67de:2f1f with SMTP id
 a640c23a62f3a-ac252ba467fmr2029916166b.44.1741699224220; Tue, 11 Mar 2025
 06:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311114936.148012-1-tglozar@redhat.com> <20250311114936.148012-5-tglozar@redhat.com>
 <Z9A1oN_XdMguNgHy@uudg.org>
In-Reply-To: <Z9A1oN_XdMguNgHy@uudg.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 11 Mar 2025 14:20:13 +0100
X-Gm-Features: AQ5f1JreteHiyUMcyR3gnnzJJK9jqv2cIeQ3zXcakcHBGBF6xFg1-fV0um1ZFkQ
Message-ID: <CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l2JwhFihtkaatwpxBqFAciD2cNJRF-wlNuAyb5HpDFs_1741699225
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 11. 3. 2025 v 14:07 odes=C3=ADlatel Luis Claudio R. Goncalves
<lgoncalv@redhat.com> napsal:
>
> In the last phrase, s/is/are/. So that "If either... or... are unavailabl=
e".
>
> Luis
>

All references I found on this topic say the verb should be singular
(since both "BPF" and "the osnoise:timerlat_sample tracepoint" are
singular). Search for "either or subject verb agreement", e.g. [1].

[1] https://www.englishgrammar.org/subjectverb-agreement-2/

Tomas

