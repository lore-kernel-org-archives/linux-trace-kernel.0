Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD3C6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 22 Mar 2023 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCVNkv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCVNkv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:40:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4AF24FF20;
        Wed, 22 Mar 2023 06:40:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D4F4B3;
        Wed, 22 Mar 2023 06:41:32 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E6133F71E;
        Wed, 22 Mar 2023 06:40:47 -0700 (PDT)
Date:   Wed, 22 Mar 2023 13:40:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, zanussi@kernel.org
Subject: Re: [PATCH 2/2] tracing/hist: add modulus operator
Message-ID: <ZBsFXN/rEG3UJOz1@FVFF77S0Q05N>
References: <20230302171755.1821653-1-mark.rutland@arm.com>
 <20230302171755.1821653-3-mark.rutland@arm.com>
 <20230318151902.78809fbe@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318151902.78809fbe@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 03:19:02PM -0400, Steven Rostedt wrote:
> On Thu,  2 Mar 2023 17:17:55 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > @@ -436,6 +438,21 @@ static u64 hist_field_mult(struct hist_field *hist_field,
> >  	return val1 * val2;
> >  }
> >  
> > +static u64 hist_field_mod(struct hist_field *hist_field,
> > +			  struct tracing_map_elt *elt,
> > +			  struct trace_buffer *buffer,
> > +			  struct ring_buffer_event *rbe,
> > +			  void *event)
> > +{
> > +	struct hist_field *operand1 = hist_field->operands[0];
> > +	struct hist_field *operand2 = hist_field->operands[1];
> > +
> > +	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
> > +	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
> > +
> > +	return val1 % val2;
> 
> Is modulus operations on 64 bit integers valid on 32 bit architectures?
> 
> Don't we need to do something like:
> 
> 	div64_u64_rem(val1, val2, &rem);
> 	return rem;
> 
> ?

Yes, we do; the build bots have also started shouting at me for this.

I'll go fold that in...

Mark.
