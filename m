Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406F3054E4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321078; cv=none; b=KzOfEr/5NVx/BUSfNHOLp/qFN/mH15D3/MyDtalGvRaHDPtIn08COc7JlW26PbdyA2ybEPqCumqtR65oCFlPFq6lDMdzqtXiZeeWo5OTTz0FfXKW7e9eXx0hEY48NDPY66fxSjYRQr+oEdbPsA9Lyv4T2bH9NsaJvYN3IXqMb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321078; c=relaxed/simple;
	bh=XqHDUeWGtKZlpgL5bske90Zr+tYUlFwy8pOxzQ28kAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QpMsb3/QAr22ty17vgIY8Tt0ecm2sUnvZvCXOyFT/pNZ1GJG1q4t29ij/w3myB1H8Ex5qKXB8HO6QuSheVU9dkBJkqltGbRCDsgdlBhPsAgyoA6IGoBMA5irb1wcxwXZLl5qEKbk1Jd066aadgWmka2u/fIG5VtENk59Y92HQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEYvSI/w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEYvSI/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770321077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkgPUbimiiBvf3rdsfEp9F8/yOvLqeGRUmwHmy7SAJk=;
	b=YEYvSI/wy9jHen6mkv3SISImDfLJU1yrPg7qK1tJMm7axQDQCFD48UVSJWWzcT4I0Xyn9X
	rSq0SDvodolk4RTz4c9KfYjsw8xsCk49vjR2YX6j7ApvxLLMN5lDBuWSol9nHMAwy8t2ja
	RSGnXoo7db14jdnp0L7ap1kGr1qd2hw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-LdJ7ZPvdMoiPkSrbmRHY5g-1; Thu,
 05 Feb 2026 14:51:14 -0500
X-MC-Unique: LdJ7ZPvdMoiPkSrbmRHY5g-1
X-Mimecast-MFC-AGG-ID: LdJ7ZPvdMoiPkSrbmRHY5g_1770321073
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 301381956094;
	Thu,  5 Feb 2026 19:51:13 +0000 (UTC)
Received: from fedora (unknown [10.22.64.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 849D9192C7C6;
	Thu,  5 Feb 2026 19:51:10 +0000 (UTC)
Date: Thu, 5 Feb 2026 16:51:08 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/20] rv/rvgen: introduce AutomataError exception
 class
Message-ID: <aYT0ZasHDLVLCMTU@fedora>
References: <20260204144914.104028-1-wander@redhat.com>
 <20260204144914.104028-2-wander@redhat.com>
 <ff532aaa9f97f474c21417401654bba73e30c988.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff532aaa9f97f474c21417401654bba73e30c988.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: cyJZSzlnt36_smSgdUFhqQgYaXVyxdSb298662MrvhA_1770321073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 01:08:41PM +0100, Gabriele Monaco wrote:
> On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> > Replace the generic except Exception block with a custom AutomataError
> > class that inherits from Exception. This provides more precise exception
> > handling for automata parsing and validation errors while avoiding
> > overly broad exception catches that could mask programming errors like
> > SyntaxError or TypeError.
> > 
> > The AutomataError class is raised when DOT file processing fails due to
> > invalid format, I/O errors, or malformed automaton definitions. The
> > main entry point catches this specific exception and provides a
> > user-friendly error message to stderr before exiting.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> [...]
> > ---
> > @@ -45,8 +52,8 @@ class Automata:
> >          dot_lines = []
> >          try:
> >              dot_file = open(self.__dot_path)
> > -        except:
> > -            raise Exception("Cannot open the file: %s" % self.__dot_path)
> > +        except OSError as exc:
> > +            raise AutomataError(f"Cannot open the file: {self.__dot_path}")
> > from exc
> > 
> 
> You probably don't want to mask all OSError in main.py and allow only this one.
> I think it's alright to keep a simpler message for wrong model file (also LTL!),
> while throwing a splat in other cases (e.g. missing templates).
> 
> But wouldn't it be better to show the error message of the OSError? 99% of the
> time it's going to be ENOENT, but could also be some EPERM or who knows what.
> I'm fine keeping AutomataError here but would at least propagate the error
> message.
> 
> Or keep it simple and catch all OSError as well, this one included.

Now that we catch OSError in the main, it makes sense to remove the
try/except clause around open().

> 
> Thanks,
> Gabriele
> 
> >  
> >          dot_lines = dot_file.read().splitlines()
> >          dot_file.close()
> > @@ -55,7 +62,7 @@ class Automata:
> >          line = dot_lines[cursor].split()
> >  
> >          if (line[0] != "digraph") and (line[1] != "state_automaton"):
> > -            raise Exception("Not a valid .dot format: %s" % self.__dot_path)
> > +            raise AutomataError("Not a valid .dot format: %s" %
> > self.__dot_path)
> >          else:
> >              cursor += 1
> >          return dot_lines
> > diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> > b/tools/verification/rvgen/rvgen/dot2c.py
> > index 06a26bf15a7e9..74147ae2942f9 100644
> > --- a/tools/verification/rvgen/rvgen/dot2c.py
> > +++ b/tools/verification/rvgen/rvgen/dot2c.py
> > @@ -13,7 +13,7 @@
> >  # For further information, see:
> >  #   Documentation/trace/rv/deterministic_automata.rst
> >  
> > -from .automata import Automata
> > +from .automata import Automata, AutomataError
> >  
> >  class Dot2c(Automata):
> >      enum_suffix = ""
> > @@ -71,7 +71,7 @@ class Dot2c(Automata):
> >              min_type = "unsigned int"
> >  
> >          if self.states.__len__() > 1000000:
> > -            raise Exception("Too many states: %d" % self.states.__len__())
> > +            raise AutomataError("Too many states: %d" %
> > self.states.__len__())
> >  
> >          return min_type
> >  
> > diff --git a/tools/verification/rvgen/rvgen/generator.py
> > b/tools/verification/rvgen/rvgen/generator.py
> > index 3441385c11770..a7bee6b1ea70c 100644
> > --- a/tools/verification/rvgen/rvgen/generator.py
> > +++ b/tools/verification/rvgen/rvgen/generator.py
> > @@ -51,10 +51,7 @@ class RVGenerator:
> >          raise FileNotFoundError("Could not find the rv directory, do you have
> > the kernel source installed?")
> >  
> >      def _read_file(self, path):
> > -        try:
> > -            fd = open(path, 'r')
> > -        except OSError:
> > -            raise Exception("Cannot open the file: %s" % path)
> > +        fd = open(path, 'r')
> >  
> >          content = fd.read()
> >  
> > @@ -65,7 +62,7 @@ class RVGenerator:
> >          try:
> >              path = os.path.join(self.abs_template_dir, file)
> >              return self._read_file(path)
> > -        except Exception:
> > +        except OSError:
> >              # Specific template file not found. Try the generic template file
> > in the template/
> >              # directory, which is one level up
> >              path = os.path.join(self.abs_template_dir, "..", file)
> 

