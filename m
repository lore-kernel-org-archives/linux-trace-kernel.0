Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE74279EF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912788; cv=none; b=ThMa5JIsNI6CoayeqUsvc1VicmjJFxWQNYkQ4zZeIWpRCDLVlu++U6Kwy6uo+6XU00j887AbRnk7nxuq/TGVitqUq81g2JzKh5yObNNoSyId6/koU1YFlbfjTzqzmeKj0DxFHtuwR2rhobQzyJ7tvFPms0cK3etq/K3YbWjw/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912788; c=relaxed/simple;
	bh=KaHgaPP5JkmipFx+mvbl5ozQOzxRxt/047W2960GcFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3qyuVk6v0LObAvv9msG7nSVMAreb4IsfP7+pVCsGnqsAjqCQgY5hQNxRMueTn9U2mvwN9b0pADxGPdnXq1tYT0P0QkqDqVA47pn2rHYA4e1zIiH4hHan+zUd+Nu/1LkBo7Qa8I6Ch7QcWyHRap6z6vM/Lmm2A4rgG3QtAxpeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0Eun3yV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0Eun3yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768912784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSDxLBtJimv4fbb9hNUxnliLbqBuc0Woc8j15mhZbf0=;
	b=D0Eun3yVO2LFEn4kF1dBIJ78RGYUkCU5+BaVedewyGh2ns2HsydbUSq1zFRRl3KHn61T9R
	qIorPya24q24GnWZlAaBXvb9LDscK3hIKcb7JI6YGfD8X5mhAv9h8ehd7Bp9dCyB+qQr51
	Ox+gCVALYWiYo7/RmG0kHvWOB65gPiM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-wxi1dJ7bMXqf18dDlZ5KAg-1; Tue,
 20 Jan 2026 07:39:41 -0500
X-MC-Unique: wxi1dJ7bMXqf18dDlZ5KAg-1
X-Mimecast-MFC-AGG-ID: wxi1dJ7bMXqf18dDlZ5KAg_1768912780
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6676E195605F;
	Tue, 20 Jan 2026 12:39:40 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0C5B1955F43;
	Tue, 20 Jan 2026 12:39:37 +0000 (UTC)
Date: Tue, 20 Jan 2026 09:39:35 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] rv/rvgen: introduce AutomataError exception class
Message-ID: <aW9ySuaPMZVm-MrN@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-2-wander@redhat.com>
 <24e308b019cf9272884091f85b6675fd05201a2b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24e308b019cf9272884091f85b6675fd05201a2b.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 20, 2026 at 08:33:10AM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > Replace generic Exception usage with a custom AutomataError class
> > that inherits from OSError throughout the rvgen tool. This change
> > provides more precise exception handling for automata parsing and
> > validation errors while avoiding overly broad exception catches that
> > could mask programming errors like SyntaxError or TypeError.
> > 
> > The AutomataError class inherits from OSError rather than Exception
> > because most error conditions involve file I/O operations such as
> > reading DOT files or handling file access issues. This semantic
> > alignment makes exception handling more specific and appropriate.
> > The exception is raised when DOT file processing fails due to invalid
> > format, I/O errors, or malformed automaton definitions.
> > 
> > Additionally, remove the broad try-except block from __main__.py that
> > was catching all exceptions. This allows Python's default exception
> > handling to provide complete stack traces, making debugging
> > significantly easier by showing exact error types and locations.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> Thanks for the extensive series!
> See my comments below.
> Mind that I likely know python less than you do, so just call me out when I
> start babbling.
> 
> > ---
> >  tools/verification/rvgen/__main__.py        | 25 +++++++++------------
> >  tools/verification/rvgen/rvgen/automata.py  | 17 +++++++++-----
> >  tools/verification/rvgen/rvgen/dot2c.py     |  4 ++--
> >  tools/verification/rvgen/rvgen/generator.py |  7 ++----
> >  4 files changed, 26 insertions(+), 27 deletions(-)
> > 
> > diff --git a/tools/verification/rvgen/__main__.py
> > b/tools/verification/rvgen/__main__.py
> > index fa6fc1f4de2f7..768b11a1e978b 100644
> > --- a/tools/verification/rvgen/__main__.py
> > +++ b/tools/verification/rvgen/__main__.py
> > @@ -39,22 +39,17 @@ if __name__ == '__main__':
> >  
> >      params = parser.parse_args()
> >  
> > -    try:
> > -        if params.subcmd == "monitor":
> > -            print("Opening and parsing the specification file %s" %
> > params.spec)
> > -            if params.monitor_class == "da":
> > -                monitor = dot2k(params.spec, params.monitor_type,
> > vars(params))
> > -            elif params.monitor_class == "ltl":
> > -                monitor = ltl2k(params.spec, params.monitor_type,
> > vars(params))
> > -            else:
> > -                print("Unknown monitor class:", params.monitor_class)
> > -                sys.exit(1)
> > +    if params.subcmd == "monitor":
> > +        print("Opening and parsing the specification file %s" % params.spec)
> > +        if params.monitor_class == "da":
> > +            monitor = dot2k(params.spec, params.monitor_type, vars(params))
> > +        elif params.monitor_class == "ltl":
> > +            monitor = ltl2k(params.spec, params.monitor_type, vars(params))
> >          else:
> > -            monitor = Container(vars(params))
> > -    except Exception as e:
> > -        print('Error: '+ str(e))
> > -        print("Sorry : :-(")
> > -        sys.exit(1)
> > +            print("Unknown monitor class:", params.monitor_class)
> > +            sys.exit(1)
> > +    else:
> > +        monitor = Container(vars(params))
> >  
> 
> I agree catching all exceptions like this is quite detrimental while debugging,
> but I see the original intent.
> When you run commands written in python, you normally don't expect them to blurt
> a stack trace when doing relatively normal things, like opening a wrong file.
> Sure that might be useful when debugging, but for a user-facing tool we want to
> write a meaningful error message and gracefully fail.
> 

One option I thought was to keep it as it is but adding a --debug option
which would reraise the exception and then print the stack trace.
But as the users are developers themselves, leaving the exception
unchaught would help them identify the error (although I am strongly
against doing this in server side code). Another reason is the case
when the code itself has a bug. That would facilitate bug reports.

Perhaps we could catch more specific exceptions that would indicate a
problem with the dot files instead of Exception. Like

try: ...
except AutomataError as e:
    print(f"There was a problem processing {dot_file}: {str(e)}",
          file=sys.stderr)
    sys.exit(1)

Which would be a common case. And leaving other types of exceptions
unchaught.

> Other story is when the exception is something unexpected (that's why leaving a
> generic Exception here is bad).
> 
> >      print("Writing the monitor into the directory %s" % monitor.name)
> >      monitor.print_files()
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index d9a3fe2b74bf2..8d88c3b65d00d 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -10,6 +10,13 @@
> >  
> >  import ntpath
> >  
> > +class AutomataError(OSError):
> > +    """Exception raised for errors in automata parsing and validation.
> > +
> > +    Raised when DOT file processing fails due to invalid format, I/O errors,
> > +    or malformed automaton definitions.
> > +    """
> > +
> 
> I'm not quite familiar with modern python best practices (so again, take my
> comments with a grain of salt ;) ), but what is the advantage of using this
> custom exception instead of using pre-existing specific exception types?
> 
> Although the difference is minimal, here you're throwing an OSError for
> something that quite isn't (e.g. wrong format for the dot file).
> A ValueError feels more appropriate to me in most of the instances here.
> 
> All in all, I would do something like:
> * throw a ValueError (or a custom one based on that) whenever we expect wrong
> data not dependent on OS features
> * throw OSError whenever that was the exception, perhaps changing the message to
> something more meaningful to us (like you're already doing here)
> * intercept only those errors in main.py and print the message without stack
> trace (if the message is clear enough we shouldn't need it).
> 
> Does it make sense to you?
> 

The reasoning behind specific exception types is to allow the calling code
process diferent exceptions in more specialized code paths, like the
example above.

AutomataError could derive from both OSError and ValueError.

class AutomataError(OSError, ValueError): ...

Which would address your (valid) point. This way, the calling code could
either process specific automata related errors with AutomataError, or
handle general file error, like that:

try...
except OSError as e:
    print(f"File error: {str(e)", file=sys.stderr)
except AutomataError as e:
    print(f"Ill formed dot file: {str(e)", file=stderr)

> Thanks,
> Gabriele
> 
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
> > index b9b6f14cc536a..1a1770e7f20c0 100644
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
> > @@ -93,7 +93,7 @@ class Dot2c(Automata):
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

