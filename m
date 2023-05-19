Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD1CC77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 19 May 2023 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjESHpY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 19 May 2023 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjESHoa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B221FF6
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 May 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbYjI1mFg3thAEdOWfyRBtPSF9SFp7VqzA4DBX9XOaM=;
        b=UfBG2unyyc6A64o49MxyDFUyiiL5aOO6t1QpHeiClWkCrdsb6aXCSByWTyKd9BDoOw7Ucu
        wHgRrwyhGbIecWJ4wV7Ru4i6aF73tSQzXh4UKE6pd/h7+eE6djIsSGlGLkeK8XSMC0D0MA
        nJ6LiH+TAQQpGaxgnVpFHnZGX76/kWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-8jk5gKwVNnagZwC444Xzmg-1; Fri, 19 May 2023 03:42:19 -0400
X-MC-Unique: 8jk5gKwVNnagZwC444Xzmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF47D800C81;
        Fri, 19 May 2023 07:42:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 759107AE4;
        Fri, 19 May 2023 07:42:16 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
Date:   Fri, 19 May 2023 08:40:38 +0100
Message-Id: <20230519074047.1739879-24-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

For the splice from the trace seq buffer, just use direct_splice_read().

In the future, something better can probably be done by gifting pages from
seq->buf into the pipe, but that would require changing seq->buf into a
vmap over an array of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Masami Hiramatsu <mhiramat@kernel.org>
cc: linux-kernel@vger.kernel.org
cc: linux-trace-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebc59781456a..b664020efcb7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5171,7 +5171,7 @@ static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
 	.read		= seq_read,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= direct_splice_read,
 	.write		= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,

