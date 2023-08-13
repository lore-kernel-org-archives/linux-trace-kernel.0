Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854DC0015E
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 13 Aug 2023 02:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHMCIZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 12 Aug 2023 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMCIZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 22:08:25 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572CB4;
        Sat, 12 Aug 2023 19:08:27 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 2925114040F;
        Sun, 13 Aug 2023 02:08:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id A38016000F;
        Sun, 13 Aug 2023 02:08:21 +0000 (UTC)
Message-ID: <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zheao Li <me@manjusaka.me>, edumazet@google.com,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Date:   Sat, 12 Aug 2023 19:08:20 -0700
In-Reply-To: <20230812215327.1dbd30f3@rorschach.local.home>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
         <20230812201249.62237-1-me@manjusaka.me>
         <20230812205905.016106c0@rorschach.local.home>
         <20230812210140.117da558@rorschach.local.home>
         <20230812210450.53464a78@rorschach.local.home>
         <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
         <20230812215327.1dbd30f3@rorschach.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A38016000F
X-Stat-Signature: 3k674k5cyum391tkwztpyf6dighwktqn
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+BdS2QWQ7CIyNzWx+BfWch9SSUrvtweNk=
X-HE-Tag: 1691892501-986183
X-HE-Meta: U2FsdGVkX182cJZYs5TTbpuQUYTU8mHjC5KKOJSgqmulNzf/BICLAZ8euaXCM5soosuO+b1scqkNGYRwVuXEzRzlpi8cGffeI3CX5kG4aSTIe0zpDYkJQjar/Q9031i6fECnVUYg+juGws/mF6V6SKrFQu8bwXzl4WEEZ0LDSUJBjndwE5wSY/0yYBX4hHreRjJdj3seZX9VVLlouyQLP//IHyNYgDrv5hgdY4bAxQmBysF8RuPhm3kRkRfJ73d+9w2HUT+R1+YlYerbNotl3H+Z89sfLvDQkyqW0ZovCMSJtzuzUGHpUeQDFT2v5XYj6rapjWQazKtyxv9961n4a8HugqcWNPugjzm+v4u3VE3kJIdE1ns4uW85xOHGwDZe
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 2023-08-12 at 21:53 -0400, Steven Rostedt wrote:
> On Sat, 12 Aug 2023 18:17:17 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > I forgot to say "for TRACE_EVENT() macros". This is not about what
> > > checkpatch says about other code.  
> > 
> > trace has its own code style and checkpatch needs another
> > parsing mechanism just for it, including the alignment to
> > open parenthesis test.
> 
> If you have a template patch to add the parsing mechanism, I'd be happy
> to try to fill in the style.

There is no checkpatch mechanism per se.  It's all ad-hoc.

Perhaps something like this though would work well enough
as it just avoids all the other spacing checks and such.
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 528f619520eb9..3017f4dd09fd2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3947,6 +3947,9 @@ sub process {
 			}
 		}
 
+# trace include files use a completely different grammar
+		next if ($realfile =~ m{(?:include/trace/events/|/trace\.h$/)});
+
 # check multi-line statement indentation matches previous line
 		if ($perl_version_ok &&
 		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {



