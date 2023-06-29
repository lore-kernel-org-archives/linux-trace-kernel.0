Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ABCEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 29 Jun 2023 13:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF2NlD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjF2Nk5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:40:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F330F6
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:40:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so582468f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688046054; x=1690638054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGXK3C74QJuocmmCvr9+ftQeIaLnPFI8vnaWY2A8whc=;
        b=i9SfxqWHjUp/WXLt1WJ2bmxBsACWRUAk0rc+V4t4bXJqrRLDp5ae8ea4vJjVjUtaCc
         mRsTi6+2uDtnKCnGs2Dl+jKyV4CiBkGpBDRR7mBIo4HbDbLrs71NrdEFYnkewf17R6BM
         E+vGOhOdG7VGFvSXeCAx/+pP/5x17yrsCSkjLHFJnVR3xBo+8teD+D1UBRg2ujWeEkde
         BWA9Ygce/DcyLo9lom39b60W2aIgOYdp+ErSnuxp0QB92mtVgyCJ4oPpvnfi69xw+4aC
         XOEK0QuZtgIgOEreL822AsNcoUWiYBOaKqve1WcHPVJW3v1PIWWFUv5YcLAe4BOPqLgY
         lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046054; x=1690638054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGXK3C74QJuocmmCvr9+ftQeIaLnPFI8vnaWY2A8whc=;
        b=jA3SVQc0ZFyaC0MpTUMVGkmof9WqoGhiSACv+R3h7j7vuCHxGA9l6QITIlcSqJ4nCb
         vfgWWVuGwbndwJmy8r+iHxDAXw+NFKj1UhV1dilsRl3BercdJAri9olJXGm9leDmNEHo
         n1k6C9QdXb6AQhGUFVe1OUhqgGJEzZytwgAPNzVIbiJLRfYOzgP26jaMfjHK6/+Vh2ar
         7/TRcjUqFO+cYnEuPmlewMkrpxr7608jXPeVM1s7IzY5chhM+Al5woYro2cBDZ00/ka7
         OiIC+gCm0Y+dGSf3BTGZGrnIO5zFtfngjUUxs4vUqN5T6UCehlxqE7Q0dgqjLXQIbi87
         vKdg==
X-Gm-Message-State: ABy/qLbYdHsTbd7Np+K4jmEUDW+fSd56zjAatKYNsJrg3el78/DBR0/8
        VqMP9zkjK3GVwHJVLPc1bIWEQA==
X-Google-Smtp-Source: APBJJlGotcoLWANjsEy3iSZbDwVbvoXo/ZN4D3rSkJn1WhYaYLlTFvVKgS8hGYILgrkTNRiMSERfgA==
X-Received: by 2002:a5d:440f:0:b0:314:11da:7c73 with SMTP id z15-20020a5d440f000000b0031411da7c73mr3210307wrq.11.1688046053981;
        Thu, 29 Jun 2023 06:40:53 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id k9-20020adff5c9000000b0031411b7087dsm2902402wrp.20.2023.06.29.06.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:40:53 -0700 (PDT)
Message-ID: <ebb24b2d-e7f4-a726-a03d-a89dc483efac@isovalent.com>
Date:   Thu, 29 Jun 2023 14:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 bpf-next 11/11] bpftool: Show perf link info
Content-Language: en-GB
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-12-laoar.shao@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230628115329.248450-12-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

2023-06-28 11:53 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Enhance bpftool to display comprehensive information about exposed
> perf_event links, covering uprobe, kprobe, tracepoint, and generic perf=

> event. The resulting output will include the following details:
>=20
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event software:cpu-clock
>         bpf_cookie 0
>         pids perf_event(19483)
> 4: perf_event  prog 14
>         event hw-cache:LLC-load-misses
>         bpf_cookie 0
>         pids perf_event(19483)
> 5: perf_event  prog 14
>         event hardware:cpu-cycles
>         bpf_cookie 0
>         pids perf_event(19483)
> 6: perf_event  prog 19
>         tracepoint sched_switch
>         bpf_cookie 0
>         pids tracepoint(20947)
> 7: perf_event  prog 26
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(21973)
> 8: perf_event  prog 27
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(21973)
> 10: perf_event  prog 43
>         kprobe ffffffffb70a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(35275)
> 11: perf_event  prog 41
>         kretprobe ffffffffb70a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(35275)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","even=
t_config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":19483,"comm":"perf_ev=
ent"}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache",=
"event_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":19483,"com=
m":"perf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":=
"hardware","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":1948=
3,"comm":"perf_event"}]},{"id":6,"type":"perf_event","prog_id":19,"tracep=
oint":"sched_switch","bpf_cookie":0,"pids":[{"pid":20947,"comm":"tracepoi=
nt"}]},{"id":7,"type":"perf_event","prog_id":26,"retprobe":false,"file":"=
/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"=
pid":21973,"comm":"uprobe"}]},{"id":8,"type":"perf_event","prog_id":27,"r=
etprobe":true,"file":"/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bp=
f_cookie":0,"pids":[{"pid":21973,"comm":"uprobe"}]},{"id":10,"type":"perf=
_event","prog_id":43,"retprobe":false,"addr":18446744072485508704,"func":=
"kernel_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":35275,"comm":"kpr=
obe"}]},{"id":11,"type":"perf_event","prog_id":41,"retprobe":true,"addr":=
18446744072485508704,"func":"kernel_clone","offset":0,"bpf_cookie":0,"pid=
s":[{"pid":35275,"comm":"kprobe"}]}]
>=20
> For generic perf events, the displayed information in bpftool is limite=
d to
> the type and configuration, while other attributes such as sample_perio=
d,
> sample_freq, etc., are not included.
>=20
> The kernel function address won't be exposed if it is not permitted by
> kptr_restrict. The result as follows when kptr_restrict is 2.
>=20
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event software:cpu-clock
> 4: perf_event  prog 14
>         event hw-cache:LLC-load-misses
> 5: perf_event  prog 14
>         event hardware:cpu-cycles
> 6: perf_event  prog 19
>         tracepoint sched_switch
> 7: perf_event  prog 26
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 8: perf_event  prog 27
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 10: perf_event  prog 43
>         kprobe kernel_clone
> 11: perf_event  prog 41
>         kretprobe kernel_clone
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!
