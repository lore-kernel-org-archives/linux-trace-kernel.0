Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C3C352A1
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  6 Dec 2022 13:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLFNZl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 6 Dec 2022 08:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLFNZk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096B1177
        for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670333086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/qcQ529qZKxUBY9ovkeJuGmrZWbcp54vb/CqVODfHM=;
        b=PzLwQy2ixkxfJa1LGLWv2C8rCmiQzGU02okspKpWReA4nxHhT+o2JoLYAWpYkJQ+EJL2A1
        zeBesJcKPPDFhPqZS52OTywaIQkQcfBg/VDuVRA6Kxk8Fxm+UVWs/fUrBpD0S/yGd9NfUe
        ZD/JSLC/PreMNlpkrC0wzVPjKpbjnVc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-Y0tJPtboMJqxLGC6FkN7zg-1; Tue, 06 Dec 2022 08:24:37 -0500
X-MC-Unique: Y0tJPtboMJqxLGC6FkN7zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82F681C09B73;
        Tue,  6 Dec 2022 13:24:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF9DE40C6EC3;
        Tue,  6 Dec 2022 13:24:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org>
References: <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org> <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     dhowells@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Fix some checker warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <998782.1670333070.1@warthog.procyon.org.uk>
Date:   Tue, 06 Dec 2022 13:24:30 +0000
Message-ID: <998783.1670333070@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Is there a tracing tree this can go through?

David

