Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4ACCA62
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451289; cv=none; b=K23P1XQpXvMdDvNcrWjlcWf5GeaHYhDcFaBI2yNWBD+A7XkyyCeb5DpNfZ47fyGotnXEKB7+tzbS5z6r/mNTGg1HQCjoTKUlBHtygRfw1tXp+X8ePRpigNY5C54vpltDmwzdzv3VWGUnircoYDpyo9qqgtQ+MC5bd/BOakNTVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451289; c=relaxed/simple;
	bh=tnVOUjDsj2VxnskY5Z0yptHrVEQVwxG0dT8IIl3wRNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBTVfEAZ9cyyZx+h7zyYCMVpZi2xjj0evprl+pGxxqUhXiLiKcVBZCE13aoD5WCXFRzOA6+Ph1j0icdz1j6I+3PYHULszAMy6ZSF6VYcztlNg7eKZBQ+Dfm8YwECB/pP21xPjaRel7mqXNQjNoP7XMqn9b6TVoMBSzCQxKqMezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W59MNMwE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W59MNMwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711451286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V6Ll6IlFLYEqaQUwYQ4cxiy9Ucc4pb0ckxmx/yckI1Y=;
	b=W59MNMwE5RGK7BFfMKuRNkKgwS6KlkpPf5QgZPMEbL0RDvYmMI7j1Wzsm2EOgbMQRlN5/B
	epKO9RxipGqc/qkbcnD7DtMJZoikFTreLEHldqqLA5BieCEY/5AAiC2ft/p/qe5NrEcZBJ
	K+CpOVxWT5ji41X/Ca1hCO05pQmyLdY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-qKh-_M7MOeG9X-G4IoCD8w-1; Tue, 26 Mar 2024 07:08:05 -0400
X-MC-Unique: qKh-_M7MOeG9X-G4IoCD8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso1015815f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451284; x=1712056084;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSYcwNLGPos48iYkpJynsevTg+PAQexnWYZ6CPBW9ds=;
        b=ikGjq2w2pn/H47RSprnLd1jwZXMs0Dw4mmKDNTIes86Y3fNipmXajhXXdpefy/PjnS
         ZG56tfB/pH5369aqO/GaXMEv+eL5ih0x4F3bmJS5T0qdi5UBjoAk4aex+XuZ/1wgaRqb
         raAEKububRQgHheWA9myIfWWVf/sQ3VtC5Lh6YFu2V51YywzuN4AfGQRQ5U8c64Fqv7O
         lvo64I4CJvp+avf3KCXGj2uHk8jJORI2evf0W+SRADPOBTg3Poh//20OfxWHYYyMZdU3
         /j21UHsxdoy9fWP+ArYIy/aSO7s3KC59xAC7YFBkL1PJq85bqrjf6h0Z0BBbDTR05+wo
         8cIw==
X-Forwarded-Encrypted: i=1; AJvYcCXRAhIMHboT352gRA6RqG/wm6YDkUyNAj6EvYSeXiQ5I7wNHUFLd4flOmekaIKVG1Mk0r1OD02oZCS8oamenkHMkoR7PnLliJIevo6KxyuMRuy0
X-Gm-Message-State: AOJu0YxjBotnGBvNAqLpTB+IhfwVhAuOgPJ7WOSNIC9e3ULz9opKl/Jn
	ipWOBb7fBi5EjMZu471J/MsFvuMin5Q5Y9DCC0M6dIF1rtrZH/C0bJN71XoYijOv69kOYsbVMtQ
	ur7L1W4iZtTdKbAHqWxXVLX0s0OcVs6NLBZvlGMsaPWNrGuf1JCDJbXhtId1LIqe9XRC+cA==
X-Received: by 2002:adf:f791:0:b0:33d:32f7:c85 with SMTP id q17-20020adff791000000b0033d32f70c85mr6279390wrp.0.1711451283972;
        Tue, 26 Mar 2024 04:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErbfogRgzkiEXP5d3pXfoBWanSDeNjli8MPnpPd2vgV8Y54N6xRG1Ve0m5offsS9WVmpSdpQ==
X-Received: by 2002:adf:f791:0:b0:33d:32f7:c85 with SMTP id q17-20020adff791000000b0033d32f70c85mr6279382wrp.0.1711451283634;
        Tue, 26 Mar 2024 04:08:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id s17-20020adfa291000000b00341b7388dafsm11274424wra.77.2024.03.26.04.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:08:03 -0700 (PDT)
Message-ID: <3186e70ecd98893710f829723f866ab92250ea74.camel@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] tcp: add location into reset trace
 process
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Tue, 26 Mar 2024 12:08:01 +0100
In-Reply-To: <20240325062831.48675-4-kerneljasonxing@gmail.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
	 <20240325062831.48675-4-kerneljasonxing@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-03-25 at 14:28 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> In addition to knowing the 4-tuple of the flow which generates RST,
> the reason why it does so is very important because we have some
> cases where the RST should be sent and have no clue which one
> exactly.
>=20
> Adding location of reset process can help us more, like what
> trace_kfree_skb does.
>=20
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/trace/events/tcp.h | 14 ++++++++++----
>  net/ipv4/tcp_ipv4.c        |  2 +-
>  net/ipv4/tcp_output.c      |  2 +-
>  net/ipv6/tcp_ipv6.c        |  2 +-
>  4 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index a13eb2147a02..8f6c1a07503c 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -109,13 +109,17 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
>   */
>  TRACE_EVENT(tcp_send_reset,
> =20
> -=09TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> +=09TP_PROTO(
> +=09=09const struct sock *sk,
> +=09=09const struct sk_buff *skb,
> +=09=09void *location),

Very minor nit: the above lines should be aligned with the open
bracket.

No need to repost just for this, but let's wait for Eric's feedback.

Cheers,

Paolo

