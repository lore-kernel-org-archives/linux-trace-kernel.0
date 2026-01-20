Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8ED423A6F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908859; cv=none; b=cpYm+IuOvYrrSI5HgW6rGGvCvdp0h96sZhGKCHD56isKPfdI1uUJKiaeAIX2/t11aeGMgQyWoa92vw9ZUfGCWe9XR+tfqc8TjyfpzUfN28WdmIF2ri7btKggKYGaSpm2mxYGrsf0jsShjaYSGlUfwfp1IB8/VughX15nXLhIBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908859; c=relaxed/simple;
	bh=TWgbgMulDWyQZWaT0FR/TZZZWd7/CF70MQ4y2P7r1Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRLfyssVajXyLrNsxTmRhOvyAgnwtZgFauWZa/gPluONxq756zfvR3cIaY7DyGghPf7Nmjwn2rcXorgCwcfyx3cE+V1jUFWc++gFZyMMwr/vmCMSs0VyB0mCZkxJxGLwHfJyy5J8MnmhgxSjwRPIJ1cF+LgQs7KpqAmzxm7K7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9W1qYQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9W1qYQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768908855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhqYGBpoZRx4ytWNC8I9/Lz/9ZjIGNcn1zvN+pd3A/M=;
	b=Q9W1qYQV25m+uqGjhmrFrqOZGm5xtH1h03GLr8EAhiJCv7YCjtTDLQPSU8EpzmLI/wmeAr
	JwuCdtiZxt8/YL+bF6uFfKkKJKYauntb+rovDXTDQwZQq6NDs0VmarNZqJop5P44iR1G1e
	AsAIVZ4CSmDRmEVKUIoBkXOQ7YjayBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-7W01c2haM8-ZoZ9_saZBSQ-1; Tue,
 20 Jan 2026 06:34:12 -0500
X-MC-Unique: 7W01c2haM8-ZoZ9_saZBSQ-1
X-Mimecast-MFC-AGG-ID: 7W01c2haM8-ZoZ9_saZBSQ_1768908851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CC8D180034F;
	Tue, 20 Jan 2026 11:34:11 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D5E019560AB;
	Tue, 20 Jan 2026 11:34:08 +0000 (UTC)
Date: Tue, 20 Jan 2026 08:34:06 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
Message-ID: <aW9nfu8r0YcGj0z5@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-27-wander@redhat.com>
 <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 20, 2026 at 10:03:20AM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:46 -0300, Wander Lairson Costa wrote:
> > Add a node_marker class constant to the Automata class to replace the
> > hardcoded "{node" string literal used throughout the DOT file parsing
> > logic. This follows the existing pattern established by the init_marker
> > and invalid_state_str class constants in the same class.
> > 
> > The "{node" string is used as a marker to identify node declaration
> > lines in DOT files during state variable extraction and cursor
> > positioning. Extracting it to a named constant improves code
> > maintainability and makes the marker's purpose explicit.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> Looks fine for me, thanks!
> 
> I wonder if we could merge this patch with 15/26 that is introducing a very
> similar change on init_marker.

The idea was to make each patch doing one thing to make the reviewer's
life easier (I think I broke my own rule in a couple of patch). But if
there is a strong feeling about the merge, I could merged them in a
possible v2 patch series.

> 
> Anyway:
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> > ---
> >  tools/verification/rvgen/rvgen/automata.py | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index a6889d0c26c3f..5f23db1855cd3 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -29,6 +29,7 @@ class Automata:
> >  
> >      invalid_state_str = "INVALID_STATE"
> >      init_marker = "__init_"
> > +    node_marker = "{node"
> >  
> >      def __init__(self, file_path, model_name=None):
> >          self.__dot_path = file_path
> > @@ -76,7 +77,7 @@ class Automata:
> >          for cursor, line in enumerate(self.__dot_lines):
> >              split_line = line.split()
> >  
> > -            if len(split_line) and split_line[0] == "{node":
> > +            if len(split_line) and split_line[0] == self.node_marker:
> >                  return cursor
> >  
> >          raise AutomataError("Could not find a beginning state")
> > @@ -91,9 +92,9 @@ class Automata:
> >                  continue
> >  
> >              if state == 0:
> > -                if line[0] == "{node":
> > +                if line[0] == self.node_marker:
> >                      state = 1
> > -            elif line[0] != "{node":
> > +            elif line[0] != self.node_marker:
> >                  break
> >          else:
> >              raise AutomataError("Could not find beginning event")
> > @@ -116,7 +117,7 @@ class Automata:
> >          # process nodes
> >          for line in islice(self.__dot_lines, cursor, None):
> >              split_line = line.split()
> > -            if not split_line or split_line[0] != "{node":
> > +            if not split_line or split_line[0] != self.node_marker:
> >                  break
> >  
> >              raw_state = split_line[-1]

