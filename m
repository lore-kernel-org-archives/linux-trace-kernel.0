Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F937C3DA7D
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  5 Jan 2023 12:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjAEMDv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjAEMDp (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C02559CA
        for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672920178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibf9GZdDPhkI3jtaNrknERTEYTDccCkdl8H694RjOIU=;
        b=RvhAkBHREsb1Tub7Aeg015FCVhcE6sH98eiz6AhLuaf6M/Q9uiKHW1/aw5kkh/9Dxifu7F
        o0spwinT1XrtCvcozMBmB80m8bKS8zldlpgRABYbKAttuWZGZOlDgS9wfykfEYfL9vvLWK
        g7xzCoi6JY1jPmTs5qKVUk9/BhEGoL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-hfBEtmlYOWavTt6O3M8TVQ-1; Thu, 05 Jan 2023 07:02:57 -0500
X-MC-Unique: hfBEtmlYOWavTt6O3M8TVQ-1
Received: by mail-wm1-f70.google.com with SMTP id p34-20020a05600c1da200b003d990064285so896544wms.8
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibf9GZdDPhkI3jtaNrknERTEYTDccCkdl8H694RjOIU=;
        b=Fk50zs73raEJ2jT6aZ0y4HBWavjNkH/ERz3oXgdUd81ZMAGrs8Gqc0oASz1onZat1Q
         CcnEH1y3nv8ZmvIMjOS9szxDXd5lD6ZK3F+eNyKUZI7djKRx0V7f+sEzA2GZvhq7Fhvy
         AasmXs0qqkdrpYcrFi84I3ANeBAOZlSs+L/2k7BuAn6Q2XGK4bwiaXuEFOZemE68fCbp
         rKmdBmT43nhoaMCd1vNSk6z863oYYnsFsWdu5sIDbgFC5KokCl/73Fuf0Ll3qK9r9SYr
         iOIjgkzjQLvX0uuFZB9Xflarr3pg037vqhJdxLDhhPjfCY73RZ67LtKGCZ19LBAvdhHP
         kGTQ==
X-Gm-Message-State: AFqh2koYsJw1IB72QI69QGqnsV7XP3aJX9HPKEVYoAYznXyecST0vE6+
        H6StrAF+PGwNQssct3tHeE7fZhXPpywWuuGeAXUWwxyiqBAgMHF7TQMLvCjCv4tqt2M0fq7qcar
        N32IAXZOpXhAtwjy15x2EuDOzU2xUtMhQ
X-Received: by 2002:a5d:6049:0:b0:2a6:4dfb:80c8 with SMTP id j9-20020a5d6049000000b002a64dfb80c8mr3170982wrt.19.1672920176276;
        Thu, 05 Jan 2023 04:02:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXupEqgUE2fErAUl67ZowlprXL7LFVObbJvJUg0S8UgOgxyazUFwvvm3lz728p9Sr5H0r2kwpA==
X-Received: by 2002:a5d:6049:0:b0:2a6:4dfb:80c8 with SMTP id j9-20020a5d6049000000b002a64dfb80c8mr3170957wrt.19.1672920175976;
        Thu, 05 Jan 2023 04:02:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-31.dyn.eolo.it. [146.241.105.31])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0023c8026841csm36155877wrx.23.2023.01.05.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:02:55 -0800 (PST)
Message-ID: <a8540626a36339bbac8603559b9200a08e4de9ed.camel@redhat.com>
Subject: Re: [PATCH v2] sock: add tracepoint for send recv length
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, duanxiongchun@bytedance.com, kuniyu@amazon.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date:   Thu, 05 Jan 2023 13:02:53 +0100
In-Reply-To: <20230105100014.1935-1-cuiyunhui@bytedance.com>
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-01-05 at 18:00 +0800, Yunhui Cui wrote:
> Add 2 tracepoints to monitor the tcp/udp traffic
> of per process and per cgroup.
> 
> Regarding monitoring the tcp/udp traffic of each process, the existing
> implementation is https://www.atoptool.nl/netatop.php.
> This solution is implemented by registering the hook function at the hook
> point provided by the netfilter framework.
> 
> These hook functions may be in the soft interrupt context and cannot
> directly obtain the pid. Some data structures are added to bind packets
> and processes. For example, struct taskinfobucket, struct taskinfo ...
> 
> Every time the process sends and receives packets it needs multiple
> hashmaps,resulting in low performance and it has the problem fo inaccurate
> tcp/udp traffic statistics(for example: multiple threads share sockets).
> 
> Based on these 2 tracepoints, we have optimized and tested performance.
> Time Per Request as an indicator, without monitoring: 50.95ms,
> netatop: 63.27 ms, Hook on these tracepoints: 52.24ms.
> The performance has been improved 10 times. The tcp/udp traffic of each
> process has also been accurately counted.
> 
> We can obtain the information with kretprobe, but as we know, kprobe gets
> the result by trappig in an exception, which loses performance compared
> to tracepoint. We did a test for performance comparison. The results are
> as follows. Time per request, sock_sendmsg(k,kr):  12.382ms,
> tcp_send_length(tracepoint): 11.887ms，without hook：11.222ms

12 ms per packet? I hope there is a an error in the unit of
measurement.

I'm unsure the delta wrt kreprobe justifies this change.

In any case you need to include the netdev ML into the recipients list,
and even Cong Wang, as he provided feedback on v1.

Thanks,

Paolo

