Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487813C9A0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121755; cv=none; b=KlJpAvbFxvswiQvOYHNb1pzFVK2FvbEVdcTMplzmaTP3OJTJskOB4tV8PeE6i085gggoxVm7QBzCSdBDfVeydT0z4zid7z0lj2jzcM0vka35xkzilZ9Yt2U2KPIPK3jebtssprCqtF7hwkmR2niXUkfcD2MFQ0dnWvRS7u0lMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121755; c=relaxed/simple;
	bh=4dCOVkO6+jaZbxpgg0GQvgunFe90UaVu5W4VrEP3Jx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdOqE6jySZQy4bA55w28CRGz1fnswzRIh60bGsESMhs34jlYseBlTeJb98N3JS4Eukgk/c4SYNMxhLndMaIoEmy8/R9xunFiWkBCF0PBCs3Z7HbzqAJMKrN+S+Za+YfB6jak9DhjmJzXf/6EEjtZcuLx8qZzmnDDpfwHMzwF5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reLWl8wF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reLWl8wF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9972a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714121752; x=1714726552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc+ioe2m0sqBtoVQtiXkBUwqMXmEVFtjvfR7brjhWPc=;
        b=reLWl8wFsimmKcL33xUvB+fXA+4UPNotH8gAJq01TJ7OTkKICq4o5fZaRwhBZA67XM
         vuohr8/XtS5oOgJTSRGOyiRXbt2Eou3nfNRB6Bu9/GNECBWsC/AYrWdV4+Ylp4JDJGap
         Um0LbyWA3aGNPbBI4aMBFUuYX20okyWmDZvp1DfwQFUCWo+II+jJLMmkgn/NR1Wt9Ee8
         TRJg2TAKLVff5Z2CKGE0Qvenz9HzIJfmzUWCgs0gcAMGrZmnTDNVYv+lpTGqP+QXMmi4
         qkonNyQhZt6mMMZ0SRL894OkYinSGZMsueTF7ypHZIwXhIXrCSSJoo/d5aYp2riGxQlh
         LHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121752; x=1714726552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc+ioe2m0sqBtoVQtiXkBUwqMXmEVFtjvfR7brjhWPc=;
        b=oyQ61Qxg4XRW6C8R+RuJz8AlO5WFQk8b3HS9Gtp19nDbsNOR18WfznND+VYDe0stxy
         cZpKtTo3rXFhU6l14R7F4OPgqY4KRvyPWfL8Rb4mZy6HcfVkybDtQV3aGafmJjOCA6lT
         20b+PA8WSBWp9/uwLjeB9yw97hQlrmt1gyVY8QI2S8seariYbVOuVyCjwrMMWgBGMtb4
         DzFCxDG1TQcLiSFj2QduT2TkUnz28XczZVfLrowWAZ+bPxA/xoOBEzMdL/8XZkGSp/Uj
         B2BfLUsr43cECBBtApFAA9qdfoOjJ6Vg9i3jEEIHtUqeT82WaxwuoBDgGgWh7xN842eI
         2XzA==
X-Forwarded-Encrypted: i=1; AJvYcCWT91C7Md0LAevp/TF78Dmpi5jlu/3NoBNBvcmaBNDRXXayVd3A//GDnmVHrwkphXL8PF5HU8J1pBTqCNsdFaCcp7HI/Sb+dEyXdcM6MQPsP1eD
X-Gm-Message-State: AOJu0Yx5CuABrKShNmcHPYdBM0Xe7WTICawWL76ysyrWB58or6XV6w2g
	bOjy+1tdYATGKntelAS9XFrmIiKJFyDSX6c4DEB+fIypRGMjDlczWlEiNFCuRNCoRhHYGxV2ATF
	iZ+VrUiO8w5XKtuvTTXIwP5e4YufBMAYkuMrN
X-Google-Smtp-Source: AGHT+IFmzULTn8UHhnGqRagdDTcH6E0Xj8BhOyQhGLFU8Vp2OPedyL0TLIRL/NA2YMPcOS2A9aGSuI8smzxx5TTeA/4=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr55281edd.2.1714121751704; Fri, 26 Apr
 2024 01:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426164730214uXfxoyj3x703nsAdqnGSr@zte.com.cn>
In-Reply-To: <20240426164730214uXfxoyj3x703nsAdqnGSr@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 10:55:40 +0200
Message-ID: <CANn89iKNtKmN5im8K4dSZGqAV8=e3bZbZ5AhxbcNbjFxk5V1Jw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: horms@kernel.org, davem@davemloft.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, dsahern@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	yang.yang29@zte.com.cn, he.peilin@zte.com.cn, liu.chun2@zte.com.cn, 
	jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn, kerneljasonxing@gmail.com, 
	fan.yu9@zte.com.cn, qiu.yutan@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:47=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Peilin He <he.peilin@zte.com.cn>
>
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
>
> 1. Giving an usecase example:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination addres=
s,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
>
> 2. Operation Instructions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
>
> 3. Result View:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3D3, code=3D3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>  skbaddr=3D00000000589b167a
>
> Change log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> v6->v7:
> Some fixes according to
> https://lore.kernel.org/all/20240425081210.720a4cd9@kernel.org/
> 1. Fix patch format issues.
>
> v5->v6:
> Some fixes according to
> https://lore.kernel.org/all/20240413161319.GA853376@kernel.org/
> 1.Resubmit patches based on the latest net-next code.
>
> v4->v5:
> Some fixes according to
> https://lore.kernel.org/all/CAL+tcoDeXXh+zcRk4PHnUk8ELnx=3DCE2pc
> Cqs7sFm0y9aK-Eehg@mail.gmail.com/
> 1.Adjust the position of trace_icmp_send() to before icmp_push_reply().
>
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJz
> BzkJFVgCTdXBx=3DYBg@mail.gmail.com/
> 1.Add legality check for UDP header in SKB.
> 2.Target this patch for net-next.
>
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHu
> FQTJvJsv-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().
>
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 68 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 72 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..cff33aaee44e
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +               TP_ARGS(skb, type, code),
> +
> +               TP_STRUCT__entry(
> +                       __field(const void *, skbaddr)
> +                       __field(int, type)
> +                       __field(int, code)
> +                       __array(__u8, saddr, 4)
> +                       __array(__u8, daddr, 4)
> +                       __field(__u16, sport)
> +                       __field(__u16, dport)
> +                       __field(unsigned short, ulen)
> +               ),
> +
> +               TP_fast_assign(
> +                       struct iphdr *iph =3D ip_hdr(skb);
> +                       int proto_4 =3D iph->protocol;
> +                       __be32 *p32;
> +
> +                       __entry->skbaddr =3D skb;
> +                       __entry->type =3D type;
> +                       __entry->code =3D code;
> +
> +                       struct udphdr *uh =3D udp_hdr(skb);

Please move this line up., perhaps after the "struct iphdr *iph =3D
ip_hdr(skb);" one

We group all variable definitions together, we do not mix code and variable=
s.



> +
> +                       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
ead ||
> +                               (u8 *)uh + sizeof(struct udphdr)
> +                               > skb_tail_pointer(skb)) {
> +                               __entry->sport =3D 0;
> +                               __entry->dport =3D 0;
> +                               __entry->ulen =3D 0;
> +                       } else {
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);
> +                       }
> +
