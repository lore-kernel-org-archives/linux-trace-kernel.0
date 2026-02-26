Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB13557F3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068991; cv=pass; b=Keu+szfyuC0liD1A5HTgFiJy/3Jk3ZNhGPUtQhTJodJG+LAcXHrl1Cl1bAjvF1eyF8sCznLbwM7Zz+FHVNsxXbduu6FQlyyYKvZ0jZw/6rYC01wyDGOzYTaLJ9Iv9E/gEuFU26is4X2FBnysTk+P3cx9/YMSIr+qPCvDOpq8xXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068991; c=relaxed/simple;
	bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIXPYvvzL5fGr8aWmYHeX3TFwM7QTxAO5nGyKLzwcdNr3++RWMUMiB9cE3LOvxX/rPdY4E6otfDv8pBMf+MwmutnPIkMF6OUXlJ8ItDkPAGcVJurd+xxlkDhDsqD2lGcEdctQ1xKWdfhjP72sZodtlKaXFgws4VL1ufjatUy7ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=tXsHCLJ4; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Q5MLxerB; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="tXsHCLJ4";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Q5MLxerB"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q0sxBr2839934
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 01:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=; b=tXsH
	CLJ4yADM+T3LoVdPgi8UuMYDqlWTAbowmGbXVLxtbZ+Zo4LU75SjgUgP/b175Nxk
	vlSVJHVdJbqF9ZZmET2nGO7Ta1EZA+AhoeLxB4uiy14gst/4Gbi19yXHD5G+1LN2
	W1qJjCgMGbilQsJPK7iZcXhmBQsibCJqIz07JGl4yFLCfb9hTOytmMC1nMcX7+A0
	ev3r4JjJFRBbf43ZioONVPAjRwByeYKRRwYxAoLhLDLFLVx7MwhoFahhLC6MIx++
	T0rTjR+0sCx/OaBGrakSEBaIxB4r8KwkUYl4O3oZW0I4NHgGqAoZbYz0+JUEgHpl
	i9wvzbZzbFwM80ZOrw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chkgqx1yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 01:23:02 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7949310b90cso6533917b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 17:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772068982; cv=none;
        d=google.com; s=arc-20240605;
        b=E+/HlXg5n36MP8u4++5gzF6FCCOm5ZHFHwsDc61SKF5Vzi5rnKhrTxI1Lna6CHeFjE
         N80BcmPlgxYeaCeVvcr2vpGZ5Z03AHf29w5KtKTJb5fnyJMLvwsIlC+3zOPc/lJW1Y04
         fH5vZHRvCjcIA2Jk5+wqpW2j/kUx4Qk4cACMzqWHHMMqO7t+wiBRhla4lHAdkHHYYFsu
         hgg4XWit0w1GBTOLUSswxwz4zBxeVkJbKCTxjM8Br2Cjte4XovYL/hIIF+CxQ+WlUOWH
         D9gkfmV3KMmDyqekVSyx2HK52uhRgzqoIhYTJ0ex6Y9BDFNiIe7o2qin1R9hO41sZgMV
         G0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        fh=/8oVxHgNQF/+/cSHAhGlapvPYG0MdPpPqTnIaZHVgfk=;
        b=UQBQrK7oEy2D5s/8yL3RQ1Nor17PODFqLSZOJpJcuhg9G/sCCgxpXOyICn5lvL2vzj
         3ZOTDP66Yt8F72REn1qDJdLN+s2/XvdLYvUX6//PRGxsqfUiqDAddn2aHpcAEesRsctu
         TYNWns7kSPMuTnjQBETGBNwU4dHbwEmirjBj27jhmEBMS97YumZc/rq2yoDLf89yFMG6
         q/daSO9/Eap3574mpd31nJBlxv0wvxufL7ih81H3lDDGzqy+bzX/+++zQU/JBdpEfXA8
         fYBjcitBxEcQzVVCr4ylhYijSH/Qng4/A+rfgDBTGlbtSW1mRQs1FqMfiEOsl4J9P/ES
         sx2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772068982; x=1772673782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        b=Q5MLxerBzgRpt/8OHfnlsMhhWsrT16F6zfLZaAJnU+8YYrSENSTLU9piNdcV/0PRM6
         7jtHdDEzr58TTfv+oYFd+mwkHcWl9ERMxn3rKpX2+rNaOQV1qk2NIeAp2K+KTfgLaCZn
         VyYSUhsQm3BbheDlmyhOwfLYsTTwQqAVlJKagFPVr/p3T4kUoI03Vx+0k1iCvwu7EqIi
         GCrpuukCOMooAg5okhGxCljibrRk/zrRs6NyVcPpsD2vBcv/IDN1BUOxGneToAmbKWse
         /IF8p5NvNmZy7viShJUF++QhEFVRfUgtNeTz7gab7Vnr58HjNJ+FG/4a1FP4NTTDn36G
         K32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772068982; x=1772673782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        b=OyLb7uWNgMVQ85HITEzLU4ZD1sroa6OBvf7xlY4p7w/7tfqTOzdw+PTTCM9LTbLdrv
         QPMK3+AG+bQMng8U76LW5r7XwKKnpoFysnQe2/zKdqcO5T6o3VyK0kG64Pn+B+HFCn+j
         LizFuAZ6D7oYk4+nVtg/arl4OYetJy9E0G/tuTC2c1UwcdmQkYl1oZEYXoyJFTPY9Nng
         Yz2JTZAgdNUNqlxqZQOf9EkGe87FY7p5/04y1AoCawgCkbTSbsdbcGP5e7NXxWfGL1gL
         kd+8PaKBuuCduXEom+fHF/n/H41QUSTmkUmvUHjZUi8ZcgY50v2zzWuw7H0cRmAYvwZ2
         SEcg==
X-Forwarded-Encrypted: i=1; AJvYcCV59i4C7gtKQxMWDr8PGn0eC636uVq7LshMeyzm3tHMqZF5Z/L7lDbLLBTn6N6nWBvmXnN43pt6yBoeNnSTvw21kb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5g5gvWCPNENdqrFvMLoXGvikwuygVir/DFd7f6oUR23fcllKT
	in6zjIgHGmKSuIVkP+Nv9Ky5zM8+g7HZaDf81R7ZlBHNBGVnL9oF8UfXLjFVfgLr7H7mBod7B/T
	rId0YrUiTp3SfW3uHU6Thhv4eM2QPRovcu3FW8eX5Pq3+IhVmF+VsBrSulTWJyNrTCqa0yxhrNQ
	Px+rYZ4yAQCv4uI82n1Npi9ZJI7ZiLgICz5z1uoN1+KN8BnTts
X-Gm-Gg: ATEYQzzuCMV9gyDdwgGrDSUyEO/l1e0gCQBCWpcd4cbmgrZxbQvzrLqZfb9odkByWfy
	3SgThO+cWvq183jU+za1Z9oEe3xJGHOil6q+41+Sv4xLpRqXfvq2efG7vr+ifvKY5La+jNvN7BM
	dSu4CPgxI+OAwkpy7ojHjmzLuwxZRLx0dtgEjkcIBrCd4+ofoZCb77ZbAWtBeXKNGn+i61DKzvm
	OXk
X-Received: by 2002:a05:690c:c4f1:b0:797:b1d7:6aa9 with SMTP id 00721157ae682-79876e681e7mr4865337b3.65.1772068981878;
        Wed, 25 Feb 2026 17:23:01 -0800 (PST)
X-Received: by 2002:a05:690c:c4f1:b0:797:b1d7:6aa9 with SMTP id
 00721157ae682-79876e681e7mr4865157b3.65.1772068981374; Wed, 25 Feb 2026
 17:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
 <20260225064723.53bcce3e@fedora> <CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
 <20260225183220.7ba404cf@fedora>
In-Reply-To: <20260225183220.7ba404cf@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 25 Feb 2026 20:22:50 -0500
X-Gm-Features: AaiRm52JbYjl7c4ahxWsFUL_dy1KHW9LDoAbY9pOXV9qXcoEJS3eOdqghy0Sccw
Message-ID: <CAOu3gNiHGBEP2oU07fY73=qOBzLJou+_wUY-6txhrnvRo84pAg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jd0tVDpAT5jI7s_9Xmjd9NrYwXigoWRa
X-Proofpoint-ORIG-GUID: jd0tVDpAT5jI7s_9Xmjd9NrYwXigoWRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAwOSBTYWx0ZWRfX0j1yz40Nqk48
 XgOpy5OorrOQhA2Xyb7kR8KQIq3j6qwoKsfultuR/jZF8fvaWLSOnhK48cXghytLnUxsFAqZheT
 fSDaZuqINl7u3MQxpPJiywRHynZ3W84fZyoyQPYGOX3Zz8KbEw3P7L6a4QlcnuwOCacdDWNfoQP
 PZhbzvtBmHRccVobTgmd0nJrPIuUct/JWabHXwkg/ki/OKDa31HnvmYMyxSn9wZG6eL1pUAD5HU
 2hjEgpk6zVv8EMBRA0jWsVcomPYYs/7I7lICB9zSOwvMh6PdwtTfU5zK8iQDsPtnhO4J3bpqHCZ
 z9P1TBL4o+f1KSIEw49fO/VBxP6XlOwB6+W3/uSbmZ9TWfUc/3t2IVPw8zu3kcyVwIexU/rn0qL
 T97YSIALy9Tfzo+RAH1ye0F1YzwD5ugB8DL/eqzlyv3EUg3BmGcyhzrANnENkRvW3HmEE9S2wsN
 MkrKVGLXAv5iEbvqkow==
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=699fa076 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=Kz1IbYNgjC_DFncX2M0A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260009

On Wed, Feb 25, 2026 at 6:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 25 Feb 2026 10:25:04 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Hey Steve, are there any extra steps required on my side to make this g=
o
> > through your tree?
>
> I see you Cc'd linux-trace-kernel which places it into the tracing
> patchwork. If there's no dependency on any other patch, I can add it to
> my 7.1 queue. That is, after I get some more time to review it a little
> deeper.
>
> -- Steve

There are no dependencies, I performed the original optimization in libbpf
(patch 1) in hopes this will make session kprobes faster then legacy
kprobe/kretprobe pairs and when it didn't, I dug deeper and came up
with this second optimization here (patch 2).

Let me know of any issues once you have time to review, in the meantime
I will roll V2 with all the fixes per Jiri's comments including this patch.

Andrey.
