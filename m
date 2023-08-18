Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A30EE498B
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbjHRSN7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379432AbjHRSNs (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:13:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3155E4D;
        Fri, 18 Aug 2023 11:13:46 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A0CB211F7DD;
        Fri, 18 Aug 2023 11:13:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A0CB211F7DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692382426;
        bh=BYuIy7pnDdrxBn1QDyJx41OLYkmIDci8eV1WMhCRBFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhqC92Ik9jgCBL6f5cR41MVJ9p7Ohsk6FtzBp8lEWuDz1UGHlP1CGj6WDTdhGYoGd
         5oyktC4SJDnG65DhEwkU1wYNC+o2F5dG//2Ril2v89WvH//Nl2dY/yB0cf6JKZ1XEE
         BINNxP4w4Ks7MKIPv8KxCC4sAXxB8BO+zetJ6Owg=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date:   Fri, 18 Aug 2023 20:13:43 +0200
Message-ID: <4853240.31r3eYUQgx@pwmachine>
In-Reply-To: <20230818114141.2a3a75ee@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <20230818213705.b4f5e18b392c4837068cba6f@kernel.org> <20230818114141.2a3a75ee@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi.

Le vendredi 18 ao=FBt 2023, 17:41:41 CEST Steven Rostedt a =E9crit :
> On Fri, 18 Aug 2023 21:37:05 +0900
>=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > That's why perf probe uses the offset from '_text'. Normal KASLR will j=
ust
> > moves all symbols. (Finer one will move all symbols randomely)
> > This should not need to access /proc/kallsyms but vmlinux or SystemMap.
>=20
> We could just pass in: "_text+offset" too.

So, the idea would be to change the existing create_local_trace_kprobe() an=
d=20
above functions to indicate the user's offset is to be used against _text a=
nd=20
not address?

> -- Steve

Best regards.


