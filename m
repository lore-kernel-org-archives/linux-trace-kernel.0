Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB2C001DC
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 29 Jul 2023 11:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjG2Lgv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 29 Jul 2023 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjG2Lgv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:36:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE700E7C
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:36:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1576C5C00C8
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:36:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 29 Jul 2023 07:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690630609; x=1690717009; bh=G7
        ULPDfdsrdijxrDvQMOPtxGQqv7cEy8/W5q0Q1kpME=; b=q0WB9yMx+ujMteebcx
        UQADCl03n73ClNB7EoU84dpOsdxFYXGU8/iqr/gX+E/VT/A4KC7XGcwTh7eteG42
        Wk78a4Ahv3M7s4vqgcOIhQpc0bIy9nWAcUYKKAcvWwI4pEo7L8ZBXyyBxRo3sPzV
        8GHxQwRDI41kirsexkgpMAvXS0MzJZcgXT0ZD6z/IUFhCzIiYMeta3a5POZn5a33
        ezqQVOG6oblUsolA7HuVvvIH0a835HYusn7tNOQ9Lb8IiJjja10z30vL8gMnddPl
        CvuBCFryHoSYrsAGssX1B2x+sUhNiXdoRmUT1rJhu2FpMVUyRZQwHTGbV5rDEg5N
        AOKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690630609; x=1690717009; bh=G7ULPDfdsrdij
        xrDvQMOPtxGQqv7cEy8/W5q0Q1kpME=; b=PqWtKiTgM7y2ifcZR7/0ohjT5RJ1+
        crdMxri9uRlxlgdPUtTJ8mGGYAlmb06dCLEK20Zo83knok6GkHZcurfJoU3bBUuI
        Nrz3alqPVkK+X0mWMnvg0+85GOgC+YhyN+nzG+advSrjJBfIwCsxdUv2kwOveudk
        5JfftVftS/4o+ksdx025atE5ECf5IYz7wZSkMFgMH8nvLjnhbuMMjK9VFHpUqx4S
        8MwEgS+2pChp944c8qYM8uoSv8MO5oOlPN35gYNLmHq34lSMpyS0JIo6vjVoxNOE
        OBQimGFSopfpooMHSjXE6sJc8u+SE8AUjWiw2znEKEcmlj3hbj4lan0YA==
X-ME-Sender: <xms:0PnEZF-YU9BXNJQ67aqImxm4cW3LvVwUo4d7C95Z2A3EVm1TGnx50A>
    <xme:0PnEZJtWB_D8vP01pWF8CrL3T1T7oApSGYYP5hu9WYIxWZjBw0r39EVra_eyhdGtj
    1xk0mzcyl-EQ42_Tdk>
X-ME-Received: <xmr:0PnEZDB6MwMvodmaQvzZUG-jnc_YskndL9RwujbhDb1eULuMTb__6c0TSOGrliIM_GU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieekgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthejredttd
    dvjeenucfhrhhomhepofgrnhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgv
    qeenucggtffrrghtthgvrhhnpefffeeujedugfdtieekgfetueehkeekudekuedtvdffff
    egtdeigeegkeeffedtgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhush
    grkhgrrdhmvg
X-ME-Proxy: <xmx:0PnEZJeS1SWMOwBqj24cQOp66I6pqp9aa85zmMjQSdjULEecCwxlEQ>
    <xmx:0PnEZKPYGk_P8691nzoNdZIvU7B8pGyMKd3-kX0Zt4gCRtulHGX-Zw>
    <xmx:0PnEZLlLO14F-fdRvvpYNTUMTcIZonFgNrFr3l64_9P-XmQgjMIpqw>
    <xmx:0fnEZNah57gPU5X3J-nwoWmA7QzG1rBEw2sFVRW4WmYA19b71Moj4Q>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-trace-kernel@vger.kernel.org>; Sat,
 29 Jul 2023 07:36:48 -0400 (EDT)
Message-ID: <60474508-419e-2070-2cfc-35196cb74964@manjusaka.me>
Date:   Sat, 29 Jul 2023 19:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-trace-kernel@vger.kernel.org
From:   Manjusaka <me@manjusaka.me>
Subject: [RFC] Add new trace event for tcp_cwnd_restart
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Folks

For now, we have the following TCP tracepoint event following 
below(since 4.16)

tcp:tcp_cong_state_set
tcp:tcp_bad_csum
tcp:tcp_probe
tcp:tcp_retransmit_synack
tcp:tcp_collapse_max_bytes_exceeded
tcp:tcp_rcv_space_adjust
tcp:tcp_destroy_sock
tcp:tcp_receive_reset
tcp:tcp_send_reset
tcp:tcp_retransmit_skb

I think we may need a new tracepoint for the function tcp_cwnd_restart 
https://github.com/torvalds/linux/blob/master/net/ipv4/tcp_output.c#L142-L158.

This function would be called if the user has enabled the 
tcp_slow_start_after_idle configuration and would be triggered when the 
connection is idle (like LONG RTO etc.). I think it would be great to 
add a new trace event named 'tcp:tcp_cwnd_reset'; it would help people 
to monitor the TCP state in a complicated network environment(like 
overlay/underlay SDN in Kubernetes, etc)

Feel free to ask me if you have any problems.
