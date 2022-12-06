Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC4AC636F9
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  6 Dec 2022 16:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiLFQVy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiLFQVf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4F10B2
        for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670343623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4kfpb8umYXrHKV3k9viGcdT7q/SXeMQNxvudhX/XS8=;
        b=aRgX27Yxp46eLOJa+bN6NpmdrS4/bQepSwYqba9h39dCxacxr3dMMYUhsfa7p73SrL3iJz
        jK9phyXF7d/ggo0VG/L5SiD1gIeinnx4ts1hDWxiMCcf+agS8WyJFzwPmsQaQLJ0eNmdSK
        kRhpYQABxYqWRbN1tJG4InYCtbT6KsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-lQMZKWMtML28_jwRx5z9-A-1; Tue, 06 Dec 2022 11:20:20 -0500
X-MC-Unique: lQMZKWMtML28_jwRx5z9-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AECD2185A7A3;
        Tue,  6 Dec 2022 16:20:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC60C15BA5;
        Tue,  6 Dec 2022 16:20:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221206225859.de7c2f68e9e50a65ac7c7c30@kernel.org>
References: <20221206225859.de7c2f68e9e50a65ac7c7c30@kernel.org> <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org> <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk> <998783.1670333070@warthog.procyon.org.uk>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     dhowells@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Fix some checker warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1158739.1670343616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 06 Dec 2022 16:20:16 +0000
Message-ID: <1158740.1670343616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Is there a tracing tree this can go through?
> =

> Yes, you can find it in MAINTAINERS file.
> We are using git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-t=
race.git

Okay - is there someone who can apply it to that tree?

David

