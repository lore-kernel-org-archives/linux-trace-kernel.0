Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1E3672B0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053151; cv=pass; b=tH31A8dW8qqbJdCelh+Z1IVth55RaqH91GTaeFmmAoFxITIyvCEqbvEDP4UtYwqWxqcH+mTBn9phekNGd58RZ8gftt2ZX2kNXn9NPiv5RZXia1bTRABIY/lBERFxOV+VPqTFD6G3aIYKXnBJug0S4mYMyHFdTd3Yi7//hlwltRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053151; c=relaxed/simple;
	bh=4j27c3ITXpBErSHQ7ijBlE2exB417P5mbmq8l9SQNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/vZDm3ouOOdNnwNfE0izj66YnF07o6w9EJIU5AJ1p4wjviQkYWBKP1heWACtex9tnKI3plEhg7C4hx7lgNINLh3EbuUtSpjw3Et54+RURPAjYpDNlOwHFG/YXMqrRPNVUNNBhgh0JKataKYRsu13NBrOse6WyPNui6K2CEJojM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EpeLMTVH; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=IG55PzML; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EpeLMTVH";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="IG55PzML"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Kfl7R791582
	for <linux-trace-kernel@vger.kernel.org>; Thu, 6 Aug 2026 21:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=; b=EpeL
	MTVHcxv76x1tW4kL6f0PWpDMX88pkGsCejHUiuCnq8z0xx8/3XgnQAU3IJt1F+8M
	dlF9iyMhSAqOLCD20RtoY2tYQaO0B/nGwS/ij6wLJ/JG0q4kd0JvPqCa+g5o3fN1
	PgtR8LsQ1hOLOsCNu6+TIqPh6YE+jQkRX9Ss3t1m1gVsWbIxXiIIgUdUAuf9lp47
	EWeUwFGewzkFtjI7p2IW1wTefeFIK4SJ5HDdA7/Jbo0oyC4YAJ/x1Lvr//tE3I47
	UiqVQlqgiUwwNQa0GEAvER8A4Shw7DvDm1pOnSZVOkAfRsb3DVYgHcmvS92dPX8/
	++RT6gGHJs2reTHbzA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t8quw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 21:52:29 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e6ae12b42so39799227b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786053148; cv=none;
        d=google.com; s=arc-20260327;
        b=Oqj4vNfZ44OKYaCifv4CYgeZGb5nOuSdktwLeIsyuS4gKQLiO2jGrlf29FGm8nNfmp
         jA7rITpZ1Plz6955cnlszk3BXj+4R7oICbBC8LN5KjpsQM1EpFsi2GoS5nZHd1Jzq6zk
         /l7jWrgnXUM6yTRTJFeyAkpml/XYFBSQxAHle+P34VmpxxqeYcf5YiaX1Fgf2p16naFt
         LSkwZ9n1qws2XDTOEaJSLhKhKo80eLyruYHDpeK/iYkxd5/o6U0mBuS1nRexn5JLgQdZ
         znyzp0ciZwDat105cU/MZVtdIDUmVgGAC3sx912wWhre1JfEK2UPEa3DsDfji5ovsaf+
         BZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        fh=1O3En+fJ9sSXklfAmp04VB01kKIEyB1T/ESinGXyz6w=;
        b=XFwbM/QEJNrKawgAq6tBsVKy9opp7c0aMgmmU/6zjdJ+NOwuWyVsv4dW6ZyR21HIs5
         HDYdBxqJsDo+cPjq9Uu7E/OS1G9PyzG44s7ebsQ4/uTC/Zekvwy1NJXgWETOozpDRGaA
         x96RM2rkLCipwbPsmhoAWRH8/MwsLtlFGpx6NzmssOTkPFGCBblfjYpncZFFqt82F72M
         QpPReSdvGglMIJrBm6sQ+EOWCnBQroWfv3bs3tqPOfbsOz5CdezsHeda4PAeWzFi2lY2
         pVElEBM2co0sl20IrNsBlzbaPm/8bSD4QDLzgGM0/NlB5NCLaW+8vFztCxWjOpuR+2XI
         MdZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786053148; x=1786657948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=IG55PzMLLNCYWzhBq+cwUO8E5Of/wmqPJPmzTS/rAITe0mS1DjeD0Kbq0pUL86flIL
         mM25R62hSyAn/KkErAQTQ4RBXpFKtQmPlMDK7tv+tNksUA95j0a1M2x3NMXFulv0Dab3
         Dq3hIyDdxswH3aa2vR9XXgzXs3MEpYgtuVq38MKvsOGmZLMiltu8h3Goz5WbIm/9yQ8T
         Vz0AxXRbUpRUqTxvF1c7hnZitkUbt9TA37aIIgMkwbvUjHLy+lOecqNo95cmS7opkDuh
         pf4TfGlwHpDWNoc22BJC+HOX2dz6V03YoinhUMq/aEmUkmdm80HcaW3nmreO9cXUWTBV
         ESiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053148; x=1786657948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=cEf1568Q986+A3gaw81udK+sGGWC0atN9HjIsLpQE2YRB3Q7ylkFRERzYkffyNFoAA
         6WOi0GXNYYXKw7PS1KIyZ1oJ8nDd2ZKFrhzGhufxbD0Nl3wcF54OknT+g3r0Kjgo02hN
         Ar01cDJ2RtKQfy5/IygS/AUEdE0eQ5jtrhhS/gfBVZnRWk/gqhu3OVZ0AJZdglhYLxoP
         +9PqqrCJLUYSiUgFrck9PJvxG/s1WyLoj8/XqkZhlCjv+NLA4BUWeeg5WjuEBulGKUAS
         bLWgDwMj0YpjV/aT+gWJ/Zqfe5uRd6UbGP8pO8KVPHl4244iNq8pfJvA2a0BFGHsAAPx
         G2UA==
X-Forwarded-Encrypted: i=1; AHgh+RrX8i18dUeZwtfKSYCUD1LgYV3yL4kIE+xPGVmUnbyXVR7j6P99FH9WS+EyIyNmJwPKcWaO++Io4UHyryhU4RPgBW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6ZSYUAkHanwAX2JIDeIV5D6DuYxuxVhuEljAM7RJjf0GDlem
	Bkbvkaoryc2pkMwMuO2URslU0yacCt5ftFUaANnknI8TJprdVYRuTxP6cUhD25I7MFRI6JOVkcq
	rOc7TVimTa83IfCN6KLeibOHk0eHBbxyHElvzyhdrQFujkh5q1ytNBE4jbUy+/b+YoNEANoqq5Y
	oYrbOYKOxaekcLAcaOmWDtlLSfLB5p91edS33kzdC9yE2/R40Y
X-Gm-Gg: AR+sD101rmx4x90rKSNGKjyE49pq6DnOlTX6pAtFWxA1vu0EPuz0g6CAPQE/vuH1WM0
	9w0zaiXKM0HY58g5E67n8pcR36FEhBwLr86+5CBCE6wo3T/pU7p7tUJnuYVoYmP7GlD0uAaUTBl
	oSInS9JG7IfByYgpDxUyBQf1NpcHJXVdWaIYQVGnvuBs2WfVB6yImz2n3lKA==
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id 956f58d0204a3-66ac2e29103mr3422578d50.8.1786053148459;
        Thu, 06 Aug 2026 14:52:28 -0700 (PDT)
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id
 956f58d0204a3-66ac2e29103mr3422536d50.8.1786053147864; Thu, 06 Aug 2026
 14:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com> <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
In-Reply-To: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:52:16 -0400
X-Gm-Features: AUfX_mxi9cOXXsF6mNBrlNENbUcZVrExzFYiYnyltoL6hOluHOkwQ37RLslPbyA
Message-ID: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a75021d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=VIIMA12v6iqWkxtvh5QA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: Ptq4qdhtMeOZm-bKd3kO3mGKF9ySdib-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfXxElGwidUwRXb
 qkxl5+fhfvUVQXpQW33LGgl15j76WtdLj+awzRyaHHfrHkWGreAl8El1Ed2epNEBXZ8Jp9P6yYM
 0Wpput4nWEecn1qlDEKzf+fuTSHpNZrq5ges6G9IFIDI0PR5aUmgyU2bxxxx6792n9HK0aOBOrs
 K0Kjf9uZYbM+v9/5WOqNNJHh2StPOoF+oaE9h5V31hE0vKKtdvp4eWlCIt8TMeiwV37K6gUPBuF
 j0DXmm48JBaJtMkpLT6Pbu57Spo8s5q1B540sAjFcvm7o1EgBZCov6hTyx63hnUsXghUxBjA+Fs
 LSfAOB0FMcRNpoDFS6uAYH0VeetIL7u2sU6443SkD8z2dKB4kWzp5CxowjSwcwvWVyr3eZwRXya
 K4WgpsExmB73i0HwTopFJ1AcjCPrsmUvxEFaFOyhK8g59/XeDXXhgAXOgMneEsiHhtAmT50PGpS
 GyxYBhC0gJ8QG5O3u5g==
X-Proofpoint-ORIG-GUID: Ptq4qdhtMeOZm-bKd3kO3mGKF9ySdib-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX15bTXAvTzfg0
 YNczXsXkRIiohUHPBK7nTlFLZhoap2kjJ2j7IrE6Ht17pYmxseg+2M4I+cD2XJgCDpSlQSbC7l4
 zJbYIfph6tKLKKgsulJ7SYpsHMdehSP679+Z0K6BbdCpywWf/cnA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060171

On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > callers rely on ftrace always being on). Refuse the write instead of
> > leaving it in an inconsistent "disables some, not all" state: return
> > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > unaffected.
> >
> > Update the docs to note the deprecation up front.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
> Sashiko's comments make sense. Other than those:
>

The bot has 2 comments.

In my opinion, the test-breaking comment is wrong as he looked
strictly at this patch w/o reviewing the follow-up live patch testing
changes which update the tests to avoid breaks.

The cleanup comment is valid but since we aren't sure if we'll need to
revert this change later if it breaks userspace in some unseen way, I
wonder how extensive the cleanup should be? Steven, can you advise
please ?

Andrey

> Acked-by: Song Liu <song@kernel.org>
>
> > ---
> >  Documentation/trace/ftrace.rst |  5 ++++
> >  kernel/trace/ftrace.c          | 43 +++++-----------------------------
> >  2 files changed, 11 insertions(+), 37 deletions(-)
> >
