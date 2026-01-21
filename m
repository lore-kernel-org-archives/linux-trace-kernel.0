Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0636AB50
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017788; cv=none; b=aoaZHs1BSdUYhN2E5BbD89WhTiiA8IKuZE2r11+4g5/JR+0OX6LDqiKcp+2U8NfYyx0Y/7F/+1qeRcrONIdZ5BRf26//524pnyKJ8oPYoyObAa+cVYKOZnRl32wTzUWS4i7cOGAkSfpaid9FeHio6Ht0KZ1fY4+8TWh6zIlF+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017788; c=relaxed/simple;
	bh=7NL74sOdS6jx6TU//DsSpkzhIA4R8AHlTYE3YKvU4FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJYSD4cEMhSrlIEfedl3dMzrnb4Mhs/Urhvrvij+XPvnCUl5fBbbaCX6eQHWPh+MmMsc/RNW3GpQjMy418LwYhMkAdwuBkLbYyFn8CiOS11XM+h3FRe51uh8HajyOL+01gXl+S4WSlLyAFMHzFztCI4/kEMX2Ex22Rjygm1NouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn/EhaTY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn/EhaTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769017779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF2eJPIUeUBW5+C0j0p10P9MTKZFU8cOI7D4R04XhHQ=;
	b=Qn/EhaTYgENLQuGXZj4WAWzgWUFxFS6VdRyzyQwu9HrUYYSSNmm/x1+L087VT+EzaxjxMw
	Z0EfeaZ/slUpjIi0Uyjf7npWrehrGD7NIyWTiBVxVI6YARYIlCRpBFjFesDPJyihsNdigq
	kKuRRa2xMWdUefFnqKV8hY2FJJSoglg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-7fXG5X3AMVy6f-589vhRig-1; Wed,
 21 Jan 2026 12:49:38 -0500
X-MC-Unique: 7fXG5X3AMVy6f-589vhRig-1
X-Mimecast-MFC-AGG-ID: 7fXG5X3AMVy6f-589vhRig_1769017776
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C9AF180045C;
	Wed, 21 Jan 2026 17:49:36 +0000 (UTC)
Received: from fedora (unknown [10.22.80.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FFA11955F43;
	Wed, 21 Jan 2026 17:49:33 +0000 (UTC)
Date: Wed, 21 Jan 2026 14:49:31 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] rv/rvgen: replace inline NotImplemented with
 decorator
Message-ID: <aXERW_6s6O6rQzkE@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-10-wander@redhat.com>
 <123046455f123d9964970dd8fcf87f2c0b780fda.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <123046455f123d9964970dd8fcf87f2c0b780fda.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 21, 2026 at 02:43:59PM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > 
> [...]
> > +    @not_implemented
> > +    def fill_tracepoint_detach_helper(self): ... 
> [...] 
> > +    @not_implemented
> >      def normalize(self):
> > -        raise NotImplementedError
> > +        ... 
> 
> Is there a reason why you didn't collapse it all on the same line here (like you
> did above)?
> 
>   @not_implemented
>   def normalize(self): ...
> 
> I see it's probably better to break the line if there is a type annotation
> making the line longer. Did you keep it separated because you will add
> annotation in a separate patch?
> 

I did review the commit before sending to make this coeherent among the
changes. This might be have scaped my review.

> Anyway this is minor and the change is good, thanks.
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> > diff --git a/tools/verification/rvgen/rvgen/utils.py
> > b/tools/verification/rvgen/rvgen/utils.py
> > new file mode 100644
> > index 0000000000000..e09c943693edf
> > --- /dev/null
> > +++ b/tools/verification/rvgen/rvgen/utils.py
> > @@ -0,0 +1,36 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +
> > +def not_implemented(func):
> > +    """
> > +    Decorator to mark functions as not yet implemented.
> > +
> > +    This decorator wraps a function and raises a NotImplementedError when the
> > +    function is called, rather than executing the function body. This is
> > useful
> > +    for defining interface methods or placeholder functions that need to be
> > +    implemented later.
> > +
> > +    Args:
> > +        func: The function to be wrapped.
> > +
> > +    Returns:
> > +        A wrapper function that raises NotImplementedError when called.
> > +
> > +    Raises:
> > +        NotImplementedError: Always raised when the decorated function is
> > called.
> > +            The exception includes the function name and any arguments that
> > were
> > +            passed to the function.
> > +
> > +    Example:
> > +        @not_implemented
> > +        def future_feature(arg1, arg2):
> > +            pass
> > +
> > +        # Calling future_feature will raise:
> > +        # NotImplementedError('future_feature', arg1_value, arg2_value)
> > +    """
> > +    def inner(*args, **kwargs):
> > +        raise NotImplementedError(func.__name__, *args, **kwargs)
> > +
> > +    return inner
> 

