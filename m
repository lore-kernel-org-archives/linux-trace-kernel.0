Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F4314D35
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345379; cv=pass; b=aX7CjKBTciBdLba4BdMOVu1Ylk98XlIfNrE3EJZIN/ddLV/ZRbpzd2zAcpKPUhN166rvRK4Q/ztYE44UExhGx8cMjHzj9It6E9CN8SBN7ePLXjlkHUfbY136IfwjzyzDNgIa1TMYhE65+178yg7/gS9TBFaEeyILUXqPJHsB70E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345379; c=relaxed/simple;
	bh=CxgVNu8OIzKW/N6Y+uKIInjNOw5NxAfNeZlPCXslq1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku4tuQtQ8DoN9BbPZWQ5hvErEfUtthmzpxZ7n6hMm35zAegCUKilp0hP2AtaIXeRWWtRWQVNxojMne/cPwjBhWYdip68jFlEjSBnvdFXIO1mV7bJa9ej/Ndv1kiIHuHhYRG5PeO5PtBnSFBLl+EBsgwk3jquRy/9IaiQDp3v1+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=e4GRIUdY; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gkVcSTk8; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="e4GRIUdY";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gkVcSTk8"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TGEdWe2782352
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=; b=e4GR
	IUdYEC0D4NyHMgg2dA+/CR0Y3qyp1HDioC86H+HL+4cMmqBxfbqEHVQXQUvmynp5
	bxjSB1GMxKiQZj49wxcHaf2jk6xUtn3pmn7f6LAyEOAZprMR/mW2pJRtHOun0Krp
	l9mDmnaoa4EmWUyxg+416Hy1+mt1bIrCzCFdCBCemy8D0dGwm7SpWc0fGXGcke7x
	8UiH4zcuInfrnsTb20q7aGO6LvLnQgEF5w/gvxdi480Ov28XKEJjgnvKLe5gZKRU
	PKMXglDnEkVjj8XK36ueFo+6Fyiy+z2KrxcRQsTkT38mk8nrde2RZTUBox0mRLei
	l3qgcvnTp5v2lgl9MQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq1eemyaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 17:16:13 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e8653ad27so24050237b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 10:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785345372; cv=none;
        d=google.com; s=arc-20260327;
        b=dV4ZNn6PAzaWwQ4tbwyio6fIIWgfId9jUtFDE2BoNUgxk/PkFeAI5XC1LmB4etCTJX
         IbhW1jX+2vuODTc8yJwiYBOLT+9Lcsw9pNQDmvESTpq7mfJ/CnFDqMBEHaPETW5vZoya
         6+jAN6OXz2HCKQ8FSuJoAw8mNPRKr3RUFCDVXA+vjj/iqMRiGNzSk5pkQfME7OGQ5kzG
         mc/zYMgO97fJkQw0ntu+15dkEutSfSFkjoVT1sqhCrMqyFHXlcfMpczbPPI6idKEv/KZ
         Qm4j57kmUGaVgXg8nlTiLIp9TljaP/zCcQv3Y8E45TO2d5ssD6yhWAbeGiKnlTbo6tJ2
         iNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        fh=7poROJx1BNRyVS2dY4CjTtjjyZK/ydLvQ6DSDDP3nv4=;
        b=kVeSU+g5sD8uDquUlfoa4FfuR9QpKol1jYkz2uIRVvMwk+qneXotLskdaNKdxsvuTY
         dd5h/0nkPw09ypImWgJrNa7QIdgNG8SSn9O99NZzFG1NgVtZZ/lWnbsAQTXkuarf5zs2
         9pypQ/vjFUxHpQccFYiu3L6WicTjovN4mueuWY7sTgjZWxoplZnPLpHmHgYoxk0wrsGR
         OTw3gMdC3lvp5wXODW6HYOZ2lHUGuFbwqlImJOM5vWPArFjI6BJgPuy4JwfcaORkVhcF
         B9hDCBbhZ0/hLzqr1HwRE7/0c2/I8Dn+msitjZlhwle3G6KEckPnQRpxbILupORgagoO
         Sqvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785345372; x=1785950172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        b=gkVcSTk8/9qeOJBSPPYPuy0/Uju9l1knImQXn/ZdAgB6umoiHynoNGSnBNYrro9pLT
         kdahEAP+MQHH5pIYjEuCKE/zbxIuQCxo/27rLdVqsyphJBcFSYNuwcE/rsh5GJunn1Pa
         jL57loQNJ6kmupKMfwQIHIRr+aMq4oJQ0JM0mdp7BbKdmwhyCsnEnOLM4D3QRCRE579r
         iq5Pg86F1NkF7G5Iw0qdIu4gxe5i7+8VOqd5VQaz90hYa+pnrVLKcoQV1Ix809GI5iCb
         eWJXITcjnHkfozd0w5wbiCZZosjI1DAYX7VJq61MvjjH0Nnln5Kv1jfI7zJrf1L6YCqV
         PVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345372; x=1785950172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        b=qrLuzrSiGwqCTrLW3PO2NI16KUjmB98NjP5mkLB7Xl6DErRvcm5XEVdJpluEoCXNPV
         4gdajpC/pgiDsVBFRKfclNkEUBTqhE7U06E9A1zlxMlBdllEapctxw3jLg88pfXw5OVR
         OgTxPili5V5MSjXIVSET8lnuboaIkfzL5+p0ddb9fKKGt1i9l5sHJlnS64gtJKLhoF7q
         nLZOj8wvQkrw4+IQ6mQT3yaenk2V4Y1QhKCZsJLr9sgYDuiV2qtZLcCuebURfLY5LPJD
         V6IzUAL6qbHCB/7GqreT3RD3wKPKGN4YXdvAB1IZ2YzPNWBIhk7QIMUMxvqRyhUxSdrY
         ngSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKH7nu500DwRSzDqQNy3shsRrFnPIFM7N5EREuoAfSl0hVe8v1GAbx6FFq/ppW15l0GgNuonf4y0cBBtNlp4HjSNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9RTg+V3nuGkcprkaZoKb0dia3NP9G0qt2TGchtzaBHo0lFkH
	WrfJAF+X6yzqL8DoRmyW+AAxJL4mKjkpdfDQelz7MepCqJ2Z7I4zqbRDVmSSd9AU0wElTfYh+LN
	fFrDQlTpWlUORugIEc6e+PM3wDNxsFU2YvPt1667n9EpPNijsMLgOfW5e5aXejxSHSsQkT0/FWO
	Ukp4tc8iqgVObHR3iLVpdeDg52HIyEZC6461yp3HncpWjJpMbtre+5Yx4CHkk=
X-Gm-Gg: AR+sD13tFdn/gJ2FZ/r3kyN6YsBRGgP2UeHmeeLFKsfDPNXJE5/LKeh3LmQCPl7gcnm
	VtDLpmMlf7LxnLpzJtIW3MWrJcXWIbAjq5KKo4w4qnX7mZ725CdvOBSMBEcwfm16Pie4GKUukpk
	Q7mFKSqW7p2c+B3PFK+R3CxdRi5ZarepTG7BHeyyRMMsvb24ZfJG+zjxpC
X-Received: by 2002:a05:690c:4b0b:b0:7db:ccda:a409 with SMTP id 00721157ae682-81f991858eemr37532567b3.9.1785345372477;
        Wed, 29 Jul 2026 10:16:12 -0700 (PDT)
X-Received: by 2002:a05:690c:4b0b:b0:7db:ccda:a409 with SMTP id
 00721157ae682-81f991858eemr37532107b3.9.1785345371866; Wed, 29 Jul 2026
 10:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com> <amn-vbX6AitcIcC0@krava>
In-Reply-To: <amn-vbX6AitcIcC0@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 13:16:01 -0400
X-Gm-Features: AUfX_mzHJi3wnVv2DObG6kIdUJfhyQomfor8B8-bBUF9HAk2TMES92n1JyZbzHI
Message-ID: <CAOu3gNiThogqw_RzEOujeEt3dMqz513ZJdjCDp3nFr3GxvVumA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, rostedt@goodmis.org,
        naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX2h6XgnUa5XUx
 GMYnOQKmfS/6ORM1ydM+QFtYS2DI+rYZq8Mm/Rmvzyq2uQpx6bZ7BSP2jaiV07OejQEZuH79JOk
 4B01WPgt1tdVF1nsWKFhG6GV5A0WCmQBrVz8O1zfIbDgXTecslSH
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a6a355d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=JqPfYqdnCgMSl0vctSsA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX8PUjEflqb6ih
 1TcLX/zJgrr4TN1EUxltOlZuLxvvh511OLreGFL/4BRojv/QIPXvPFw1Isncz0yq1jkIlnGL8pl
 j+ZTPgT5SzeyYMNW89d2G2mw25p6CUzR/skMCSz28hblEK17v/soV4Vvy/L0d0rlzXdUTCratOE
 N/Rf/5IaIPXGbr9u7I+xjFpeqZUb8RXh6H/RR2sk0Qkma1MTcxVkLVsXSD6zeocrDG6P5c9fde1
 hloBOgxljNCvKYy0TyBB9F+3pGxeMKtaF+ZqTCh33ouotWWZTITbnjQGsNXLQQaTIBtDyan5gTX
 JsukxdAUBBT0lHV14WTa2LMRI3wmHtjhZmJa6KAbHqmzNCzwjwJgle+qwpQMZPibHZCGwfPHMTJ
 Ngs8kzmlJTE7bqaERJuvQ+V0V2hgp43DIJyIO5hYP5UOaIJF5Wh0Aqw69fcJJcx/q905zH23iqK
 ePlbB0m+eBxKAVi6sOw==
X-Proofpoint-GUID: JdHnI7UBTGN4FAE92mLdV12xfg4PVY0i
X-Proofpoint-ORIG-GUID: JdHnI7UBTGN4FAE92mLdV12xfg4PVY0i
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290134

On Wed, Jul 29, 2026 at 9:23=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jul 28, 2026 at 08:59:59PM -0400, Andrey Grodzovsky wrote:
> > Cover the FTRACE_OPS_FL_PERMANENT fix on BPF trampolines and
> > ftrace-based kprobes/kretprobes: attach a fentry, fexit, kprobe, and
> > kretprobe program in turn and confirm kernel.ftrace_enabled=3D0 is
> > refused with EBUSY while attached, then succeeds once detached. Also
> > confirm a new fentry/kprobe attach is itself refused while
> > ftrace_enabled=3D0 is already in effect.
> >
> > kprobe.multi/kretprobe.multi/kprobe.session are intentionally not
> > covered, matching the production change's scope.
> >
> > Skip the kprobe/kretprobe subtests when CONFIG_KPROBES_ON_FTRACE is
> > off (e.g. arm64), read back via skel->kconfig->CONFIG_KPROBES_ON_FTRACE
> > (same __kconfig idiom as progs/test_fill_link_info.c).
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
>
> hi,
> I have some links active already after boot which makes test to fail:
>
>   [root@qemu-1 bpf]# echo 0 > /proc/sys/kernel/ftrace_enabled
>   bash: echo: write error: Device or resource busy
>
>   [root@qemu-1 bpf]# ./test_progs -t ftrace_permanent -v
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   test_ftrace_permanent:PASS:skel_open_and_load 0 nsec
>   check_blocks_disable:PASS:attach_fentry 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/1   ftrace_permanent/fentry_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_fexit 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/2   ftrace_permanent/fexit_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_kprobe 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/3   ftrace_permanent/kprobe_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_kretprobe 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/4   ftrace_permanent/kretprobe_blocks_disable:FAIL
>   check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 =
(errno 16)
>   #145/5   ftrace_permanent/fentry_attach_while_disabled_refused:FAIL
>   check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 =
(errno 16)
>   #145/6   ftrace_permanent/kprobe_attach_while_disabled_refused:FAIL
>   #145     ftrace_permanent:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>   Successfully unloaded bpf_testmod.ko.
>
> jirka
>
>

Thank you, Jiri. I will address this once the decision on whether to
proceed with this
route or, just make ftrace_enabled obsolete, is made.

Andrey
