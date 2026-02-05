Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109C32AAA2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321216; cv=none; b=Kumcbp6+KqvpKypYmEzVRDuSuXgRwrwn0GMUyQV1x9knVqQfsmpbbNEHs926CQIAjKQFBUMKP19UOP9W23nOL3JO3pEnTQdwE7p2TpNdeGs/4BKzmb1DXn/EMUFM3XjefEUyeKPJ8dK2fHWZJsgAUbomjldQN7EhBQFavIVAb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321216; c=relaxed/simple;
	bh=kjoxwzYU1c9fwr8V05cvYQphHRCRpD47RCxciAmcAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fbgKNcoDi4ynBySw9NF0/TI1rwD09k0EjzUjKYu6ojc+tHH6cnlXUvglnTgddC+EYf2RH680Z7nVDQtxCFc79lOHfinJXpRXLFep0TlTOKLb4oulKV3SGtEkUc3ukUV4BbPuM4uSn0kIl0u8YhHuTpeAY7LNJ/feKXg9kiBws0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwUJmeHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwUJmeHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770321215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siurf8Ibdez1eG66/L6D7OM0u7oT0sAWmPlmkzdbtd4=;
	b=NwUJmeHIB63scrQ2GoTSolvYk6S2kzoCSY87d1/bMBKDr0370SGs23SvA7cD0vGpJcwvKD
	TJTJqoCxyuGdiV8Anxn/JYtsAZMTPO2/VWE1thawoc+7Y7GXFsyocPsFUVis7nGFM+NDfr
	ib2kNMtRaZjgggNLU9+tKtSuwyhTcOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-7_aXvCXmPVyqZoVpQ15mNg-1; Thu,
 05 Feb 2026 14:53:30 -0500
X-MC-Unique: 7_aXvCXmPVyqZoVpQ15mNg-1
X-Mimecast-MFC-AGG-ID: 7_aXvCXmPVyqZoVpQ15mNg_1770321209
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F9F19560A7;
	Thu,  5 Feb 2026 19:53:29 +0000 (UTC)
Received: from fedora (unknown [10.22.64.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB4E519373D8;
	Thu,  5 Feb 2026 19:53:26 +0000 (UTC)
Date: Thu, 5 Feb 2026 16:53:25 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/20] rv/rvgen: introduce AutomataError exception
 class
Message-ID: <aYT0600kS-T3qh_Q@fedora>
References: <20260204144914.104028-1-wander@redhat.com>
 <20260204144914.104028-2-wander@redhat.com>
 <3552738a6de5a56e1eb5d985dfc1b414dd1a67d5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3552738a6de5a56e1eb5d985dfc1b414dd1a67d5.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: uJmvNYxo2970bK6tq9IEeKpPLWYB2KQ7juN2KswB6tA_1770321209
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 07:50:57AM +0100, Gabriele Monaco wrote:
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
> 
> Looks very good, thanks.
> Now I wonder though why is LTL not included in the change. ltl2ba.py raises a
> few ValueError that should probably be treated just like these AutomataError.
> You could either create a new exception class or share the same for all model
> errors (DA and LTL).
> 
> What do you think?

Good point. I am still learning the code base, I missed it. I will add
AutomataError to the of *ba.py files.

> 
> Thanks,
> Gabriele
> 
> > ---
> >  tools/verification/rvgen/__main__.py        |  9 ++++++---
> >  tools/verification/rvgen/rvgen/automata.py  | 17 ++++++++++++-----
> >  tools/verification/rvgen/rvgen/dot2c.py     |  4 ++--
> >  tools/verification/rvgen/rvgen/generator.py |  7 ++-----
> >  4 files changed, 22 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/verification/rvgen/__main__.py
> > b/tools/verification/rvgen/__main__.py
> > index fa6fc1f4de2f7..3bd438f8476ed 100644
> > --- a/tools/verification/rvgen/__main__.py
> > +++ b/tools/verification/rvgen/__main__.py
> > @@ -8,11 +8,15 @@
> >  # For further information, see:
> >  #   Documentation/trace/rv/da_monitor_synthesis.rst
> >  
> > +from sys import stderr
> > +
> > +
> >  if __name__ == '__main__':
> >      from rvgen.dot2k import dot2k
> >      from rvgen.generator import Monitor
> >      from rvgen.container import Container
> >      from rvgen.ltl2k import ltl2k
> > +    from rvgen.automata import AutomataError
> >      import argparse
> >      import sys
> >  
> > @@ -51,9 +55,8 @@ if __name__ == '__main__':
> >                  sys.exit(1)
> >          else:
> >              monitor = Container(vars(params))
> > -    except Exception as e:
> > -        print('Error: '+ str(e))
> > -        print("Sorry : :-(")
> > +    except AutomataError as e:
> > +        print(f"There was an error processing {params.spec}: {e}",
> > file=sys.stderr)
> >          sys.exit(1)
> >  
> >      print("Writing the monitor into the directory %s" % monitor.name)
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index 3f06aef8d4fdc..6ecd5ccd8f3d3 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -10,6 +10,13 @@
> >  
> >  import ntpath
> >  
> > +class AutomataError(Exception):
> > +    """Exception raised for errors in automata parsing and validation.
> > +
> > +    Raised when DOT file processing fails due to invalid format, I/O errors,
> > +    or malformed automaton definitions.
> > +    """
> > +
> >  class Automata:
> >      """Automata class: Reads a dot file and part it as an automata.
> >  
> > @@ -32,11 +39,11 @@ class Automata:
> >          basename = ntpath.basename(self.__dot_path)
> >          if not basename.endswith(".dot") and not basename.endswith(".gv"):
> >              print("not a dot file")
> > -            raise Exception("not a dot file: %s" % self.__dot_path)
> > +            raise AutomataError("not a dot file: %s" % self.__dot_path)
> >  
> >          model_name = ntpath.splitext(basename)[0]
> >          if model_name.__len__() == 0:
> > -            raise Exception("not a dot file: %s" % self.__dot_path)
> > +            raise AutomataError("not a dot file: %s" % self.__dot_path)
> >  
> >          return model_name
> >  
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

