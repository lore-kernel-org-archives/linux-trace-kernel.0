Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540D42FCA7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557806; cv=pass; b=WV220rcn8y4+tFNidrAUPYYaPOGodmLW+GmosiU+bF2elC1k4QRF45ncbicMLu1Iay1f9S8o74a2tDPvw3nE5ICwmad3K7vmlJ0DUf9Osp5ThIgDUbRNlK2+tjkbBSHbLLoBrKUOxU0uH+kJsJ+DE09RoqE0OmMJrVWjhG0VwPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557806; c=relaxed/simple;
	bh=WNezRESdeFPDAlEzFR5fG9NIdHxdKFvMbj9OQd2by6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJmd7YYFeqTX+TGAhjj8wf8tyBe7ODqCG9PO77kxL+v2MHSJQvX0mJelzkqhsmlRChZQxKaUu45UNyL+yDyjJdVHHHjaFPPTBQgqj3IZJUD7M+WUqUylkPwVLkM8IhFB6j3ISFiJAcDIZnskg8dZgJ0G3KnruIKVnStQDd72pzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQ6C/ZmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fs4WswJL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQ6C/ZmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fs4WswJL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDqjG92325115
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=B7WLVX7htmQVpgibeea9FWxKs4BdmsGk4O71G1I1VnM=; b=cQ
	6C/ZmGu25L7iHIsTcYsk189LDQaJRBBoYybi7OC5h2i3ZiTG/aLKeDRISeO69V5Q
	oO7jueBvrYn8NccMVQuq08+V75zAkML6BxGHSyBQe/3BVB383YaioRyYVep4/8Tj
	sYBL/O/XJiukLWx5OPHXjux+nN4WaaT4brzn5jRJhDZQYPoR1kFWUbClwJAbPtIV
	oWcj0xj3ZMN2+2ju89jbclM+OayrWEKqTtXL9mcttapQcLJgIDu10qNduD0E0oPm
	iMggHGZraTaQ/mdxUtuWzxDs4kyAo7nYd/5Xdlw4ZeptoMlZgijT16igjzxkWkyN
	eexhUY6V3cth4tWWLP9w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs51b7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 14:30:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f113592bf3so151724226d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 07:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784557803; cv=none;
        d=google.com; s=arc-20260327;
        b=WNY8OX9rcerzZYTGza4Z5PA3HO56vnfpl9daLWKilJW3AnwzGVN7lg+b/SB0GTKnt6
         R1/ki1bJhRA5XyVgFdnYB6ilh8Wd+PF0Zr4FqFhjUeK6nQU9kbomYQZ4xNwPPLRlVasU
         N99r5uIkIu8/hbpxpsqRBqi4V7Vl4DyFR9IfRTyGfO21Op/889qb0PCfeeb3Kfgch28m
         vEI+1SpOmrSQB8bSEVdu1O60bk1CV+pEYcERDH9FqBcVWPDDDXcd7TgY0dE1D2KqNems
         N+DWpU/amabX15JK/03qZDkJsM+thS1RIeQm9y46PJafZuLtD1ivOFXrHkUiW5ArtTkL
         Kq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=B7WLVX7htmQVpgibeea9FWxKs4BdmsGk4O71G1I1VnM=;
        fh=yEX4DAkDvX/D9lXV0ZgYlZXB6DzffnwUWLIMmHd2RgQ=;
        b=A4yP31yWrL62bs0RQ7TkA00DhJz5y9hgK5E9L5iv1sAbOED+u4Paxr3Klc4R5lGZSH
         QlErA4+XjQZ8Zm58K7ntonDIDkl6lAfu2SPOIfUf0eW1E95cUg3TofnQ291oYYR04art
         sWu7UE9Ij9DJR4dU2/Kc5S0VuDPipNae0/sD1cxlUjdwxOxDeo4Qhu+jpgWj5p5DCUq4
         44rL08Q1aLOTKztht58PH4GuqxxtgUj98/W2wKv5A2fIyG7t5LRFFSQQDGAecFKJhHQz
         HUcZx5ClbSqljVPPswZS0IJvBSB71KgFOm6EAjOFTKOEXbQZw5l8etqBaVMZBU0zzCcu
         RNRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784557803; x=1785162603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B7WLVX7htmQVpgibeea9FWxKs4BdmsGk4O71G1I1VnM=;
        b=fs4WswJLAuRbPMxqyDRY3OonlUNfuxWQcY/VrH3K95KtqBQOW02uUY0UkUcqBFNZ7L
         aa+JYEDj4VyhcOrqfgVsjddYZ1ky2LlER5EDTDiV2RL/gvHd23wOSiHwPiA9aDDpB/Qh
         mWBBQaj+tDENlmjmDrIrIT2mQrmJKox3lhi2RPhy1CyHtN7Kvmho1tx1jWYPJ1ZRjzy2
         LOHRFNvoRg5oVX2gGdKjiBGMYrOxt+Q+xa2+NtnEvku2JtGmoXAlHaPiBq8qL1ehr0Bc
         rMKo4/BeV9D3Sml6hKjuTlBT8y9kwcWuFinEq+GLgL1ZkS1scmbYdUQbtaR9mCPN/AsW
         L3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557803; x=1785162603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7WLVX7htmQVpgibeea9FWxKs4BdmsGk4O71G1I1VnM=;
        b=TxrphuQJAlcoytU26kY4AYu7+PgOCLiXpc6kTdaVXobFPDiFMFUCdzh8dYv4ptNe/B
         xoUX2AJeknmhNqygtZOgNh8Waj+PRLcjZ1BE5PCA4nZiqK4SnkFixQz+xcfWG2LA5/aV
         gmSoMpksZODUTuE9LPXICukydR0xOCh9fU+WfskNaFiG6rKt7Gupq4t+ErpIstgrmD0F
         e6iEbh4cjjgX+OhKOcCz+zphnhb/fXqe1dqrKHSSHPHvsQr5HhwjjC8t+GXCyYwHnhLP
         rnQqkUYjeaIbqEWgov5KSq6HJlPv5deS0+V/BElA9m1WBd0yvR0YrStYz7ACAPiE7ZNv
         3TZA==
X-Forwarded-Encrypted: i=1; AHgh+RpntCnyCyxu+qZ+M9Jkc6XtbLvRphoE1DdsUKNQYxD1a3psSUfCTjk5aZU1mS5rYYIdk0PHQW4wqpy4cobOfijsvpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFILuAcxpgX+8L6JGk8rvgMNCaoZLK/FaaUdlPrK7UN4hPLBVf
	VVnIx536Czgv0MrF/yGjpbEuTCp1bVPg0W+cdkPgf6Qn+fL1wfw3b4JYdnyaSa7HUUBtDt9yOTr
	kBX5Q2+tirMiAmfjr8oIkdvzHpwXywHveowUzVQtVWI40U/CnseEY9zzJW7i4ZymYNWdMDLl3AA
	b5fWQvTEpBakd5BScmYk/a6qhiZeZZnrB3OIbUqICr2ONJmfy8mQ==
X-Gm-Gg: AR+sD11q/16tMCc9XKEkrGgpf586QgMyk9sOSskTp8t1TDCJHF1ueEQTTW7VlrHqTod
	9egdWi7jUstk6+9NDqLBKmA/pUrFgzjxzGXXwPxCPmKzun7ixTf0y1XUhh2tJ8W38y4DjFMXT1l
	p4bSn+ytzq2/Dv/jDXhPSLVpkOD6hDF+UO9MmPMjyTydq8ccvWQG+/5zWlUQ==
X-Received: by 2002:a05:6214:1303:b0:8ef:1fc9:935b with SMTP id 6a1803df08f44-90778312673mr171659076d6.12.1784557802502;
        Mon, 20 Jul 2026 07:30:02 -0700 (PDT)
X-Received: by 2002:a05:6214:1303:b0:8ef:1fc9:935b with SMTP id
 6a1803df08f44-90778312673mr171658536d6.12.1784557801823; Mon, 20 Jul 2026
 07:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com> <20260713115936.GM276793@cmpxchg.org>
In-Reply-To: <20260713115936.GM276793@cmpxchg.org>
Reply-To: pintu.k@oss.qualcomm.com
From: Pintu Kumar Agarwal <pintu.k@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 19:59:50 +0530
X-Gm-Features: AUfX_mz15A386kNJsD5wp1TjLtovmzPE_18-TTLhtNcPJULkWXUVGWf0PXnOeuo
Message-ID: <CANqwyPhJ82Vy9_BUzBumVJKxdMySv+YVaMHNTCOtz2sGOh_h2A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] psi: Introduce in-kernel PSI auto monitor feature
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        surenb@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
        peterz@infradead.org, mathieu.desnoyers@efficios.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, pintu.ping@gmail.com,
        nathan@kernel.org, ojeda@kernel.org, nsc@kernel.org, gary@garyguo.net,
        tglx@kernel.org, thomas.weissschuh@linutronix.de, aliceryhl@google.com,
        dianders@chromium.org, linux.amoon@gmail.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, shuah@kernel.org,
        linux-embedded@vger.kernel.org,
        "tim.bird@sony.com" <tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfXyOCoJEuiTHN2
 t37NFLmnW3PPJIIiscY0VtyVVwBQaPh4wDctEvOs4b/gXc3PkXHbB0lyDN6F1F23/rKujFVBdO3
 cU1EXNRPwKI6n8HDFhJ9EOR3WynfBWI=
X-Proofpoint-GUID: CjCXzrUfjkU1lBYVd81R8R0Qlfn653sk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX+tQNYk7KoPwO
 WHr8HhztNerJ6JOX/1nwU6FvOkZhMHGIj6WhjM52zlJe+e8dWmiFIFdNSsPyKLa2gmxsBgsdsz1
 adhbiiIR6jPqziqSsARVKkr9eNODcB5i5WZyczCPrAcpek8fDLSEwCkUB3SXcuvOG97UH0srW4M
 WMnlEZm7ci8XXpDPuVBowqkXb0Yq1nM0LBeW0qtRZ+PyTZ8DDfXSXBVFzPerO0r6m/ciqg4vrDA
 bbdOZdspPfY3YukvnErkgJnevaPs0OSp3kdcIjHjssQhblv/AIwjvfxKE9VIyVE3F1tPwOhqCkX
 as6pcQvTPKL+wNHZi7h7kkcr67b7yVs7cwd44AXKrvgqjb7movqc9uTkxJqTB19iL8OYO/wj7wE
 SKawY875kBl3rMOs7c8Dj/OEbaTOlylzH8xDl4NzbcMouXDTZ9AxZxwOiVJXRPqdi/GJrqlTuvh
 qaAMEu/rFAluTN+De0g==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e30eb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ufHFDILaAAAA:8 a=vtzPRGNYVNIivFiWXQUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-ORIG-GUID: CjCXzrUfjkU1lBYVd81R8R0Qlfn653sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200161

Dear Johannes,

On Mon, Jul 13, 2026 at 5:29=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jul 02, 2026 at 10:46:05PM +0530, Pintu Kumar Agarwal wrote:
> > Hi all,
> >
> > This RFC introduces an in-kernel PSI auto monitor aimed at improving
> > root-cause visibility for resource pressure events in Linux systems.
> >
> > Motivation:
> >
> > PSI already provides an excellent mechanism to detect CPU, memory and
> > I/O pressure and includes trigger-based notifications via pollable
> > interfaces. However, it deliberately avoids attributing pressure to
> > individual tasks.
>
> Why is this necessary?
>
> > In real-world systems, this creates a gap: when a PSI trigger fires,
> > users still need to determine *which tasks caused the stall* by combini=
ng
> > multiple tools (top, meminfo, vmstat, perf, tracing, etc.), often after
> > the event has already passed.
>
> I've never found myself needing to identify which specific task was
> stalled. Tasks competing over a shared resource are interdependent.
>
> Consider this scenario: Task A, B, C are allocating memory and
> creating pressure together; B randomly becomes the sucker to hit
> direct reclaim and making room for the other too as well. Why is it
> meaningful to know that B stalled? It caused the resource contention
> no more than the other two.
>
> Then A and C refault: A is fast, but C happens to hit when the flash
> drive is running garbage collection. Why is it meaningful to know C?
> Again, C is no more the culprit in that situation than the others.
>
> The meaningful thing you can say is that the domain as a whole is
> under pressure. Who exactly becomes the lightning rod is noise.
>
> That said, if you do need it, why not use delayacct? It already tracks
> the reclaim, swap, thrashing time and events that also go into psi on
> a per-task basis. It's not sampled, either.

Thank you so much for your detailed feedback. This is very helpful.
Your point about resource pressure being a domain-level phenomenon
rather is well taken.
I agree that pressure is often created collectively by multiple
workloads, and that the task experiencing the stall is not necessarily
the root cause.

The goal of the RFC was not to identify a single culprit, but to
provide additional attribution context and surrounding tasks around
PSI events
by capturing the major resource consumers and participants exactly at
the time pressure becomes significant.

Your suggestion regarding delayacct is very insightful.
I think there is a utility under tools/accounting/delaytop.c which
already provides task-level delay information in user space when run
manually.

I am currently studying delayacct, taskstats and the existing delaytop
utility to understand how I can correlate PSI auto-monitor attribution
using delayacct.
The idea could be:
PSI threshold breach -> PSI Auto Monitor trigger -> Delayacct provides
delayed task list -> Auto monitor dump / create trace events
PSI threshold breach -> PSI Auto Monitor is triggered -> Collect
per-task delayacct/taskstats data
-> Identify tasks with significant reclaim / swap / I/O / CPU
scheduling delay -> Emit trace events / logs / structured report

One additional motivation for the in-kernel prototype was early-boot
observability.
Unlike a userspace monitor, it can capture pressure events and
attribution context before userspace services are available,
which proved useful in several embedded boot-time investigations.
One more point is that the psi auto monitor can run and trigger on its
own during early boot.
It can quickly help to identify bottlenecks during boot and aid in
boot time optimization at both kernel and user space level.

As a side note, please see one of the snapshots below captured during boot.
# dmesg | grep psi
[   30.948653][  T420] psi_monitor: pressure high: cpu=3D50% mem=3D1%
io=3D11% (thresh cpu=3D50 mem=3D60 io=3D40)
[   30.958342][  T420] psi_monitor: logging top 8 tasks under pressure:
[   30.964959][  T420] psi_monitor: pid=3D2637 comm=3Dpcid-loc-api
psi_flag=3D12 oncpu=3D0 cputime(ms)=3D443 rss(kB)=3D21976 io(kB)=3D0 score=
=3D13203
[   30.977392][  T420] psi_monitor: pid=3D1974 comm=3Dsyslogd psi_flag=3D0
oncpu=3D3 cputime(ms)=3D643 rss(kB)=3D2156 io(kB)=3D272 score=3D4565
[   30.989137][  T420] psi_monitor: pid=3D2597 comm=3Dqwesd psi_flag=3D4
oncpu=3D3 cputime(ms)=3D104 rss(kB)=3D7964 io(kB)=3D0 score=3D4502
[   31.000540][  T420] psi_monitor: pid=3D1493 comm=3Ddlt-system
psi_flag=3D0 oncpu=3D3 cputime(ms)=3D370 rss(kB)=3D1984 io(kB)=3D136 score=
=3D2978
[   31.014588][  T420] psi_monitor: pid=3D15 comm=3Drcu_preempt psi_flag=3D=
0
oncpu=3D2 cputime(ms)=3D443 rss(kB)=3D0 io(kB)=3D0 score=3D2215
[   31.033593][  T420] psi_monitor: pid=3D420 comm=3Dkworker/2:9+events
psi_flag=3D12 oncpu=3D2 cputime(ms)=3D351 rss(kB)=3D0 io(kB)=3D0 score=3D17=
55
[   31.051276][  T420] psi_monitor: pid=3D2713 comm=3Dsdir psi_flag=3D0
oncpu=3D1 cputime(ms)=3D124 rss(kB)=3D0 io(kB)=3D20 score=3D640
[   31.065800][  T420] psi_monitor: pid=3D41 comm=3Dkworker/u8:1-memlat_wq
psi_flag=3D0 oncpu=3D3 cputime(ms)=3D52 rss(kB)=3D0 io(kB)=3D0 score=3D260


Thank you once again for your review and valuable feedback.
I will explore more and improve the design for v2.


Thanks,
Pintu
