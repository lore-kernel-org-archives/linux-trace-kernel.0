Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50947B43B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030324; cv=pass; b=HzYw9x6xce0gEzzGChHxhAdMW8JCA4T1nKwRDXsvNJOcBmey3KEE7H7F4HLv5Q6SAR+QuNSjJU+bRBUCD5AGIE3V07xLm2JH7x/WCmbhHinAWGyFV7jBGTo9ZAHqxix0a7uxwZpptaqhMs+4BHzxAcP7XzHoYjxr9TMC7jhuoq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030324; c=relaxed/simple;
	bh=q1yKAchAKLYq079ovpGA477d3rJNusw7Xe8p+FR68lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nALN0/IDocXjL0YIdWY0KAx64Fgdb1ex6XE2D/Bc69iDsM158BnkQCTScw9cx5jJBWYvq3SgMLTqBQPtEfjn5mzxZ37gzjmwqQrGHBn33cZcxhSZNMw+5FJlzKxc4JfT/2cew1Seh4ZaHnYyZ3Nb2FuhZSLlT54iVAmRwqpgt8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cD4zTm5M; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jUwr7YyE; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cD4zTm5M";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jUwr7YyE"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676F1Fgg791548
	for <linux-trace-kernel@vger.kernel.org>; Thu, 6 Aug 2026 15:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=; b=cD4z
	Tm5M17fPCDrNyQnDpnqttK1cC6kuMPVg4/jD/NafaBCKl0S12uY23MLt8b4AzTR1
	tNtAlGU6iP65NOCAbZGM/AFS1P8A8jFJtgC+Gka/cS6al6ZUwTehMeQPyb49rJQ/
	ju69mZ7d/ia/w2ssTJghneL2trmQpwiu1JI2o4ewFKbpqsE6YwXRn0dDomX5s3g/
	TzyMqV1CTrn8xM9VTU4dBjoou0s9LDokE/Lr5b8h6sM33N7AXcM7VGNgAH/pGgMd
	cZseJx5SSRaCvi1pYSw14VZx4tyjkzymIS24edQKmC4N7Wsh7W7pzQS0ATIUeCok
	yJesokBCRMEHIY5+8g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t6jfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 15:32:01 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-667656a12c5so5928078d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 08:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030320; cv=none;
        d=google.com; s=arc-20260327;
        b=B0jHvm0UViRWv7CZpsKD80MyY7bfx35vMC2/RuPb8zBKbXjZxW78ZToxA3ZcrGkknZ
         zDj3gX5AmXqA/yX9PL/9kZyliAqRH74l4jtrc7hnV7eHtLCVTR+wWTlxh+bWz4eDFsnJ
         /BLYkVOd1637VuV8RLHId/K3WUBlRXWQg2hhYt6ZJddrongRVfCScSYVrYGQUBSh6nYY
         FcE+E7gWEG5SkzvlqEYwGa66pCo5nUSIB+RQwoV9To7ePMZ4zMIPfmybt0HNWSD6/Jed
         BHbbi32OvRW/WohPccMkj8MX4iXOY6QJx1pByiy6hhyD5ownIG7LxE6KBaeCx5zefgbL
         DAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        fh=Cn/4xxM1t3zMR9gpfKCtKDvI21ziAeIfyNnx+Y5BQOU=;
        b=YcPvkgRpJXLY3Xq5flYI3VTW74hfQfbSzwfkZUX+dARksfxRZLfu10zZxLreYx/j47
         8/ou6sl/yf3SANzSEvu+SLzCPNMboS4Yy8WasiCym5nw+mhGGfP/dD6CpYnit1TudqWY
         ZsR4L7L6iQQIxm0BoSAM/kgMz7QiY7xvkuNyv0BrfaDITfLvx1Xhimzznf3NUeCRSTjk
         I2E6UxuRUPAXKjGDDCKLA1XQMywGcEAGWaFES7H6wb1gQBJ3v+JThIQMLIlHsG1JL21c
         WEzQWabLjm38MGeQEtjKD2zHBeQGrGcKqKED6XZftIt8TNaV5kMRdTGtDbq/ymecPnty
         7J2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786030320; x=1786635120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=jUwr7YyEutR2ntg8mjiTkWr8G03wYaEMxMSDpwpeIO060yep4vdjVdLNRvdpnYyHTh
         Q2ja/+7W1N89qUtLLHRF2mQFXrKXQw1q7TKbCzzFGzCy8phwlVgFemybh4MsP+CUcdjM
         lH3nwDnpqcmGChjsCbjpWZo8NYW4J3mXH8mmmFURQgcdbKZ6uwkM5LI8SnhJQM7acml/
         nJF1EDne5owqizd5ct1e56AakdqqUXBYpxOm46SB/gVYfEap/FbxbnM7SCuYg+6J+inK
         m/vmdXVQn4/+CKbdIOqRKB//rjFCjK81hRMhXyWjyAMGfCvtjZljQDehl4TxvX+xCLXI
         vkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030320; x=1786635120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=Eor9ulK9Ca+WpvbnkWaLnnjdjAOozYZr+PZfe4a1hPshw1eJ8Q2Jqza6xxoKubQHtj
         zAHrDGh0oBXoRLr/G/x81a55FF2Pm6weuc6oSFOjlL04f+nYpzT0zRXhU2f1yWXHNzly
         KLpkejWBQ52ujzqB8oOzITmSmykeiQFZsQL07PaoJTGU+zX1tivHSXxMg5ntLKa7Cx2A
         CV1FiPmEwFAm30GxijuTUjAB+/eVF27v9NMldrC/Kit+vTCJJccSBC9Gb9vLFM7TJTuQ
         FKYQ6otY7ZrQIrEJfb/p6os72DqEPFLvdxS15H25NHBwHcCqVLLrqCyBysBmWljv4wQV
         gABQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdGguNG+emECqjkF645tNfNGmfPkMcBwzVtAzdWBqWdQqp91nUnoT0YrvweG2cRh3yz9NldyFTVDxmhHYKC89TGHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorhPnIaM4clV36o8YCpmUVu7IwxPLfobFdMlI/a3z/Qn1KesT
	+85e+GvVRCO7xYiMEuWzC5RNnn2Jgoo+DfROKocTpidDeNvuTeetdsztkB406XAaQSKqkJ59djW
	suD+SAbPhti3Qb9GEXmJt5SUUs3gzRpMIZBz9SWoMwaFjrfjLPL3Iaty48Ii0l1ZoamiU3FUEnQ
	aAAqoy4xhwIwMOW+iQcFX/skdNlrCEgT1DnicnXmecsLrV4mg8
X-Gm-Gg: AR+sD10PY58LLBPgJGQkZiyD4Tn6ZIjihrI0RtMMtYtKefHZMA5twjm3VMi2xH4nHyP
	HtoyXi7mfITeqIHYtyAED3YoNa5CreFugsPygpMJE2dcsVt45bRQn07n94XLXJ0s3nBPHTgZ7tQ
	MiSU5Cha38NmCHsumG7cAtqSN398ziR6AkNAPm3Jo5k+5pSacrc62Ia7FYvw==
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id 956f58d0204a3-6699aa7511dmr7229028d50.34.1786030320375;
        Thu, 06 Aug 2026 08:32:00 -0700 (PDT)
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id
 956f58d0204a3-6699aa7511dmr7228964d50.34.1786030319671; Thu, 06 Aug 2026
 08:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
 <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com> <am0-QoUNQo4p2sBg@redhat.com>
In-Reply-To: <am0-QoUNQo4p2sBg@redhat.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 11:31:47 -0400
X-Gm-Features: AUfX_mw1nwxsETix0HLa6WjJrBSSAU1_0A9CQBJUP5Fq4BDIA8mjk_ZZNVuhTmY
Message-ID: <CAOu3gNhFL+1JmWRVwJVq4xUn-8mENkNwYexCwpFZ8FaZY82SRw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        corbet@lwn.net, jpoimboe@kernel.org, shuah@kernel.org,
        jolsa@kernel.org, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a74a8f1 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=20KFwNOVAAAA:8
 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=P5XVh-r7Nk77isVNjX_M:22 a=Fx-rEtueDibNKiZPBj-h:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: ZxdMvdYlfSpJsOEVkZBIrTZi_E1hJHrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX9Xy5kR6UKNXt
 t/DuVWM61eaYef6EpK3X/J7gxH4j7Xv5F/XqhYDRroRbbz19msvQJwQ7u2mNOV28eq6oJnfXQcH
 aNr+E9GkVR4DxFEW5cVOCCQHmzSclOPyoyY6CldVdt3F9VB+pGW8fIXmmGG8NWfVpCJWrwYaB3X
 jg49ze259XrIlnLtZW5LK/T9Qj2+ggXg/ZnBROV8m4H+k0HuPriRg1Nu2UQmN2ATbT865ig3wTc
 /ptVueBV1kBwQhV8ktkVKIRNyyb2KYsC/PhrAX1/eIGwiqwsDMh7+QxpDMD54H/RPwxpk2dVl0m
 UIjNpqG5R/NgGbzfZI0TZnyAKFz/GudpmqQauXNK+qbHmEKkd9tAYO2xvDBQZuW4YzoJ0xDHbDn
 oTN8/Wf5061nfklexV3hSF3r6NJRmqyfjh4XtWF2u9ijWNYSLm2faAt3tmsQHbRCH3xAUBVLd6q
 Tia5kj5EGvBwuVnLmEg==
X-Proofpoint-ORIG-GUID: ZxdMvdYlfSpJsOEVkZBIrTZi_E1hJHrK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX6itM1lszo6yP
 FuRqfdiTFomEV+xMx38LURZgTc6LaqUUO0y68gcOLgVJX7sRTX/VcQM85o5Hmw1iBlrIl8bcFud
 WDQJ95DNv8+hh4+udUmmC7TZTZAUvnX1GOE6LW/cUMm0Vcv1lnpf
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

Thank you Joe and Steven for your comments; I sent V3.

Andrey

On Fri, Jul 31, 2026 at 8:31=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Fri, Jul 31, 2026 at 01:53:58PM -0400, Andrey Grodzovsky wrote:
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Miroslav Benes <mbenes@suse.cz>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87Va=
VkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$   | 13 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZc=
qFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAJf9tNxM$         | 45 ++++++++++++=
-------
> >  2 files changed, 41 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotP=
ltPcR5ezYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$  b/to=
ols/testing/selftests/livepatch/https://urldefense.com/v3/__http://function=
s.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZ=
cqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > index 30dc677b2f45..7fa4bda70221 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > @@ -126,6 +126,19 @@ function set_ftrace_enabled() {
> >       echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#    can still disable ftrace on this kernel. Newer kernels deprecate
> > +#    the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +     local result
> > +
> > +     sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +     result=3D$(sysctl --values kernel.ftrace_enabled)
> > +     sysctl -q kernel.ftrace_enabled=3D1 &> /dev/null
> > +
> > +     [[ "$result" =3D=3D "0" ]]
> > +}
>
> Small nit: AFAICT, it doesn't really affect the test pattern, but it
> would be a bit cleaner if this function restored the original value
> instead of always turning it on, like (untested):
>
>         orig=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
>         result=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
>
>         [[ "$result" =3D=3D "0" ]]
>
> --
> Joe
>
