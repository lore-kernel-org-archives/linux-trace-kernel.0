Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DF1487E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721788; cv=none; b=T+822BI646zkrXhG5ZfS24uUin//MS/+umVRbB4nGlCi9QVeV6hktnSUz57BTxeZAFo+aCX3VaMhWDVYkVCSiEOocbZb94VD/syYWqkrrcDcb91mgXUgds5ojqi6JU8i5/Iw5WGMoFeHpAl4bB2z+pfMgaZogbTH9Kda267JrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721788; c=relaxed/simple;
	bh=uavAtHbbN3wQA0RD3ulWRt0z+k0una1EQWf9hoUW1BM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Fr2UzJwo+ZE/11KCIlZC2eICOdxFycjjxtwp2Z6S1n0V6AfHEfhRONoZHtKF3kGaXQIOQGeWSKy7teRJt2kUoMkkSDeZqEEVQ2MFRrO9/fBXW8II56PW+a/yIRCFuYkwTZbgwiDRp2mHELXolD6r7RXmPOYFyILJ4UPX04pnIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kpiecuch.pl; spf=pass smtp.mailfrom=kpiecuch.pl; dkim=pass (2048-bit key) header.d=kpiecuch.pl header.i=@kpiecuch.pl header.b=QKYnyT2M; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kpiecuch.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kpiecuch.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kpiecuch.pl header.i=@kpiecuch.pl header.b="QKYnyT2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kpiecuch.pl;
	s=protonmail2; t=1711721775; x=1711980975;
	bh=XSOAdqJpyfSHfCeU6acCpcquRaO7YcpuH9ps2eZ81Qc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QKYnyT2MT3X+IvAg007rmO5tM4QgA1ZnOrYu+iUtBSZ4vO8oEImI/Zd3Gft60InVf
	 t2zR4P6Zyrg81Bc+ZEx8RR8uG64VpZ6UKpKCzP7Cfoaih53XB+d7SooSETf1Yf4jBN
	 FhC8xND3rJamFienpwzQw4ac54QWHvy81snlwRLVwjClXDjS9wE7fikmQLabnvKayv
	 MPmAwgWU8KAQ7c7n0rud6FtcPwX3bOyfAcIUK0N/cozmqw712ckO1OeBUbvr7XWnvX
	 GDWPdBxFJAcSCDjulWaLHM3DTOHDxz9gkoMvTdBmTHXGrPuGDkW6/+LWWuDzk0Hrc9
	 u77Z7vwdV3cHA==
Date: Fri, 29 Mar 2024 14:16:10 +0000
To: linux-trace-kernel@vger.kernel.org
From: piecuch@kpiecuch.pl
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, Krzysztof Piecuch <piecuch@kpiecuch.pl>
Subject: [PATCH] perf-ftrace: sync funcgraph options with perf-ftrace interface
Message-ID: <20240329141547.22579-1-piecuch@kpiecuch.pl>
Feedback-ID: 27245028:user:proton
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Piecuch <piecuch@kpiecuch.pl>

Adding overrun, retval, retval-hex and tail options to set
off-by-default funcgraph features.

Add nocpu, nooverhead, noduration options to turn off funcgraph
features which are on by default.

Signed-off-by: Krzysztof Piecuch <piecuch@kpiecuch.pl>
---
 Documentation/trace/ftrace.rst           |   5 +-
 tools/perf/Documentation/perf-ftrace.txt |  16 +++
 tools/perf/builtin-ftrace.c              | 118 ++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |   7 ++
 4 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rs=
t
index 7e7b8ec17934..9a608a59dce6 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1384,9 +1384,8 @@ Options for function_graph tracer:
 =09of each process displayed at every line.
=20
   funcgraph-duration
-=09At the end of each function (the return)
-=09the duration of the amount of time in the
-=09function is displayed in microseconds.
+=09At the end (return) of each function the duration
+=09of the function is displayed in microseconds.
=20
   funcgraph-abstime
 =09When set, the timestamp is displayed at each line.
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Document=
ation/perf-ftrace.txt
index d780b93fcf87..0cf7b3301478 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -121,6 +121,22 @@ OPTIONS for 'perf ftrace trace'
 =09List of options allowed to set:
=20
 =09  - nosleep-time - Measure on-CPU time only for function_graph tracer.
+=09  - overrun      - Show number of lost events due to overwriting when
+=09the buffer was full.
+=09  - nocpu        - Don't show the CPU which the process was running on.
+=09  - nooverhead   - Do not print the appropriate delay sign next to
+=09long-running functions (' ' for sub-10us, '+' for sub-100us, '!' for
+=09sub-1ms, '#' for sub-10ms, '*' for sub-100ms and '@' for sub-1s, '$'
+=09for sub-1s runtime).
+=09  - noduration   - Don't show function the end of each function (the
+=09return) the duration of the amount of time in the function is
+=09displayed in microseconds.
+=09  - retval       - Print function's return value on exit. Error codes
+=09are printed as signed decimals, other return values are printed as
+=09hexadecimals.
+=09  - retval-hex   - Print all return values in hexadecimal format.
+=09  - tail         - Print the returning name of function next to
+=09closing brackets.
 =09  - noirqs       - Ignore functions that happen inside interrupt.
 =09  - verbose      - Show process names, PIDs, timestamps, etc.
 =09  - thresh=3D<n>   - Setup trace duration threshold in microseconds.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index eb30c8eca488..1c58fa744758 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -225,9 +225,16 @@ static void reset_tracing_options(struct perf_ftrace *=
ftrace __maybe_unused)
 =09write_tracing_option_file("function-fork", "0");
 =09write_tracing_option_file("func_stack_trace", "0");
 =09write_tracing_option_file("sleep-time", "1");
+=09write_tracing_option_file("funcgraph-overrun", "0");
+=09write_tracing_option_file("funcgraph-cpu", "1");
+=09write_tracing_option_file("funcgraph-overhead", "1");
+=09write_tracing_option_file("funcgraph-duration", "1");
 =09write_tracing_option_file("funcgraph-irqs", "1");
 =09write_tracing_option_file("funcgraph-proc", "0");
 =09write_tracing_option_file("funcgraph-abstime", "0");
+=09write_tracing_option_file("funcgraph-retval", "0");
+=09write_tracing_option_file("funcgraph-retval-hex", "0");
+=09write_tracing_option_file("funcgraph-tail", "0");
 =09write_tracing_option_file("latency-format", "0");
 =09write_tracing_option_file("irq-info", "0");
 }
@@ -425,6 +432,42 @@ static int set_tracing_trace_inherit(struct perf_ftrac=
e *ftrace)
 =09return 0;
 }
=20
+static int set_tracing_funcgraph_overrun(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_overrun =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-overrun", "1") < 0)
+=09=09return -1;
+=09return 0;
+}
+
+static int set_tracing_funcgraph_nocpu(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_nocpu =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-cpu", "0") < 0)
+=09=09return -1;
+=09return 0;
+}
+
+static int set_tracing_funcgraph_nooverhead(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_nooverhead =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-overhead", "0") < 0)
+=09=09return -1;
+=09return 0;
+}
+
+static int set_tracing_funcgraph_noduration(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_noduration =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-duration", "0") < 0)
+=09=09return -1;
+=09return 0;
+}
+
 static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
 {
 =09if (!ftrace->graph_nosleep_time)
@@ -464,6 +507,37 @@ static int set_tracing_funcgraph_verbose(struct perf_f=
trace *ftrace)
 =09return 0;
 }
=20
+static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_retval =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-retval", "1") < 0)
+=09=09return -1;
+=09return 0;
+}
+
+static int set_tracing_funcgraph_retval_hex(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_retval_hex =3D=3D 0)
+=09=09return 0;
+=09if (ftrace->graph_retval =3D=3D 0) {
+=09=09ftrace->graph_retval =3D 1;
+=09=09set_tracing_funcgraph_retval(ftrace);
+=09}
+=09if (write_tracing_option_file("funcgraph-retval-hex", "1") < 0)
+=09=09return -1;
+=09return 0;
+}
+
+static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
+{
+=09if (ftrace->graph_tail =3D=3D 0)
+=09=09return 0;
+=09if (write_tracing_option_file("funcgraph-tail", "1") < 0)
+=09=09return -1;
+=09return 0;
+}
+
 static int set_tracing_thresh(struct perf_ftrace *ftrace)
 {
 =09int ret;
@@ -525,11 +599,46 @@ static int set_tracing_options(struct perf_ftrace *ft=
race)
 =09=09return -1;
 =09}
=20
+=09if (set_tracing_funcgraph_overrun(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-overrun\n");
+=09=09return -1;
+=09}
+
+=09if (set_tracing_funcgraph_nocpu(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-nocpu\n");
+=09=09return -1;
+=09}
+
+=09if (set_tracing_funcgraph_nooverhead(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-nooverhead\n");
+=09=09return -1;
+=09}
+
+=09if (set_tracing_funcgraph_noduration(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-noduration\n");
+=09=09return -1;
+=09}
+
 =09if (set_tracing_funcgraph_irqs(ftrace) < 0) {
 =09=09pr_err("failed to set tracing option funcgraph-irqs\n");
 =09=09return -1;
 =09}
=20
+=09if (set_tracing_funcgraph_retval(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-retval\n");
+=09=09return -1;
+=09}
+
+=09if (set_tracing_funcgraph_retval_hex(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-retval-hex\n");
+=09=09return -1;
+=09}
+
+=09if (set_tracing_funcgraph_tail(ftrace) < 0) {
+=09=09pr_err("failed to set tracing option funcgraph-retval-hex\n");
+=09=09return -1;
+=09}
+
 =09if (set_tracing_funcgraph_verbose(ftrace) < 0) {
 =09=09pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstim=
e\n");
 =09=09return -1;
@@ -1094,11 +1203,18 @@ static int parse_graph_tracer_opts(const struct opt=
ion *opt,
 =09int ret;
 =09struct perf_ftrace *ftrace =3D (struct perf_ftrace *) opt->value;
 =09struct sublevel_option graph_tracer_opts[] =3D {
+=09=09{ .name =3D "overrun",=09=09.value_ptr =3D &ftrace->graph_overrun },
+=09=09{ .name =3D "nocpu",=09=09.value_ptr =3D &ftrace->graph_nocpu },
+=09=09{ .name =3D "nooverhead",=09.value_ptr =3D &ftrace->graph_nooverhead=
 },
+=09=09{ .name =3D "noduration",=09.value_ptr =3D &ftrace->graph_noduration=
 },
 =09=09{ .name =3D "nosleep-time",=09.value_ptr =3D &ftrace->graph_nosleep_=
time },
 =09=09{ .name =3D "noirqs",=09=09.value_ptr =3D &ftrace->graph_noirqs },
 =09=09{ .name =3D "verbose",=09=09.value_ptr =3D &ftrace->graph_verbose },
 =09=09{ .name =3D "thresh",=09=09.value_ptr =3D &ftrace->graph_thresh },
 =09=09{ .name =3D "depth",=09=09.value_ptr =3D &ftrace->graph_depth },
+=09=09{ .name =3D "retval-hex",=09.value_ptr =3D &ftrace->graph_retval_hex=
 },
+=09=09{ .name =3D "retval",=09=09.value_ptr =3D &ftrace->graph_retval },
+=09=09{ .name =3D "tail",=09=09.value_ptr =3D &ftrace->graph_tail },
 =09=09{ .name =3D NULL, }
 =09};
=20
@@ -1160,7 +1276,7 @@ int cmd_ftrace(int argc, const char **argv)
 =09OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 =09=09     "Set nograph filter on given functions", parse_filter_func),
 =09OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-=09=09     "Graph tracer options, available options: nosleep-time,noirqs,v=
erbose,thresh=3D<n>,depth=3D<n>",
+=09=09     "Graph tracer options, available options: overrun,nocpu,nooverh=
ead,noduration,nosleep-time,noirqs,verbose,thresh=3D<n>,depth=3D<n>,retval,=
retval-hex,tail",
 =09=09     parse_graph_tracer_opts),
 =09OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 =09=09     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", =
parse_buffer_size),
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 558efcb98d25..a94b92389cb8 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -18,7 +18,14 @@ struct perf_ftrace {
 =09unsigned long=09=09percpu_buffer_size;
 =09bool=09=09=09inherit;
 =09bool=09=09=09use_nsec;
+=09int=09=09=09graph_overrun;
+=09int=09=09=09graph_nocpu;
+=09int=09=09=09graph_nooverhead;
+=09int=09=09=09graph_noduration;
 =09int=09=09=09graph_depth;
+=09int=09=09=09graph_retval;
+=09int=09=09=09graph_retval_hex;
+=09int=09=09=09graph_tail;
 =09int=09=09=09func_stack_trace;
 =09int=09=09=09func_irq_info;
 =09int=09=09=09graph_nosleep_time;
--=20
2.44.0


