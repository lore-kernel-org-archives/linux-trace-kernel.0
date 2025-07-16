Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE72F0042
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656888; cv=none; b=QO2V7uFDSZEgXlhHTkOVRyB/6rhi+/kbDZmaVtr7aVCma/SEzk3ZLL6nKYBgjG/Frv55XCCYFS/gk1RVP5nnM53VSqt3Hx/AXszsGAV+sxs9+L5TkxF8heM2Q4GniYwHTIrKOanVS6n8JQsCw69H4q2ys+A9YLtdNcmCuCFYzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656888; c=relaxed/simple;
	bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTH6etXBOHXGT850yB4cNp27YdXcH8Cat/wsxjJ8Mvl9ia60M8DrYwXI7Phb6DFEM7X5BUbW2Q+p1d676fEZfm6ns/5vKxKnew6doJlWkznJ4tK2XMTQu5EYu+0xpVszeoDwadx55L4enjUJsIrnbLmLgu2KNCy0B8jkL9jD9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6Hd7IEZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6Hd7IEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
	b=O6Hd7IEZ48skx0KD9BVbOL2RspVc9AF8zRlaCm96FDCQYKzaXY7ywMBdVW6ZMeTnoGlUHl
	BqH9oTG433umNSNcoIIbwRANDLirNuSPkXOWNPPIMkYIy4tVlWGahXuDY3DatNtHy4fewq
	hrMV5PxMguU5kcuqK1I33OgH5v/HRA0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-7BuOdpLZNFm-iOTFCdZ-tw-1; Wed, 16 Jul 2025 05:08:03 -0400
X-MC-Unique: 7BuOdpLZNFm-iOTFCdZ-tw-1
X-Mimecast-MFC-AGG-ID: 7BuOdpLZNFm-iOTFCdZ-tw_1752656882
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4538445e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656882; x=1753261682;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
        b=mi4+ny3TZqiDzCYsn8mKt8szs4pKVHRyuFFILCZw0TxNxMoRjNG1iOJUSajqSK8fAe
         UHe2WsK6mlGkWuiyVCjzIK2ERw4n2dLtSp/IgNq/NbpRJyvGBevIGHdDZXNzGHlj5kBS
         9sLmqB3eESklx3u2CF5X0oV9z64N1uDgUHDsQ8DoHtJYTOTBNKo8VDjLUxFtUr7oyuM6
         Nk+/nmiAHlAUBl76L0raMUjGmcrCS4Plff61H47xftlfywrje+sDbxwKxorzN5bVsrXs
         C+gpa2RYTcT9eDwqd8pvWPc5SlXKytV7oc5OYYrNdLPYK0FUPXsg0rqBEuf6Xk8vtB8C
         EZQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXn+Kmx8ry6EEfUWqVAYfjb5DO1tztbQPelqiAETNEsMnTx3HUSnG1wVcsRSAQ5kI/CtkSQpxYL4m6WJmlRTWo5/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MkYbbDVJ/5/8lFSG+cqWH+9Tz+dbmYQ7URiXFNaTlVO4+697
	3rX9uyT3hik0KNkaK03BxJJ8mEH0wccxUF7rYZ6Tyknf0LZs5cG9yff9s3SIBNpg7SAIhlK9ySS
	5vjkIC9Tu59T9kzyeZcX8HZpahwMHwLP6PCxQlhURdRvQLtpUO4R7JwWNA4Pgk1BiYRdx/etXtA
	==
X-Gm-Gg: ASbGncu744eHhNolV2NFeI0epO43hhSROLgvQgRR+hHAZqieuiaBM3JcuvbbLaP6DTM
	0qWc8J6gD9UAwkZFHCosdDMhRobnldN2akIgGzPltUQVKW76EysU+m0+cBE1zP5CgC/1c1k0TP/
	YIuwJ9CS3HsYeVCHf4c/Bn4A43rhI4NzcSzg9b2w1s60h6NL3vJRd8z5UsGe1lZD8+2fQ8S41fv
	lalG6AFSxypqSpw07nBoicawhFYRlbRpq1D8eJkVY/bk7c6uyM0kiSEjx771BidUKPWA3l+fSdt
	RZp9h+suQJvUVzXfWphCq1grcQVDqy8VAwXs5xbjezsu9lhZ5DrbIqQ9q4MrvVUokA==
X-Received: by 2002:a05:600c:1c96:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-4562dc7b418mr21706735e9.7.1752656882183;
        Wed, 16 Jul 2025 02:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOpGvTBaJnZqTeWSH6ykKhVOwvfDAdzZU8N/vWUacHNon9SjRxLwmhdvqbVLNRlns6FZQz5w==
X-Received: by 2002:a05:600c:1c96:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-4562dc7b418mr21706365e9.7.1752656881758;
        Wed, 16 Jul 2025 02:08:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm17600498f8f.19.2025.07.16.02.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:08:01 -0700 (PDT)
Message-ID: <9647cdbf96f13fa3fcbc784549175b68d371187f.camel@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 11:07:59 +0200
In-Reply-To: <20250716081304.K_nK3k46@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-11-gmonaco@redhat.com>
	 <20250715150828.BNdFfB8h@linutronix.de>
	 <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>
	 <20250716081304.K_nK3k46@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: gb0F6koYcoiDP69ssi2NvGpyy-fRxKKCp61NUvps5l8_1752656882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 10:13 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 05:24:11PM +0200, Gabriele Monaco wrote:
> > Right, I didn't make it obvious in the commit description since I
> > thought it wasn't too important.
> > Those are the monitors whose lines are going to be longer than 100
> > columns later in the series.
> >=20
> > Changing it there saves a bit of complication in the next patches,
> > where I only add lines for new events instead of splitting the line
> > /and/ adding the events.
>=20
> Ah, that makes sense. I thought the script went wild.
>=20
> > Do you think I should mention this in the commit description?
>=20
> A maintainer once told me that the rule is "one thing per patch", not
> "half
> a thing per patch".
>=20

Sounds like someone familiar, good point :)

> This does make the diff easier to read in the later patch, but I
> think it
> is not worth it. For this case, I can easily review the later patches
> by
> regenerate the files.
>=20
> So I suggest dropping these.

Alright then, I'm usually finding the diffs in emails confusing so I
prefer to have as much help as possible. But here it shouldn't be a big
deal indeed.

Thanks,
Gabriele

