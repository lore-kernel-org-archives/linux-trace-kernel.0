Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFD2DAFBB;
	Fri, 14 Nov 2025 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100377; cv=none; b=UiN/zqIWYBBhAvDzU09K+W6uahAN0xEn+y8vEB5oDrsOACUq7gsd27DGxaPvpOwFPd/5LQblAPOlMxdFarZSPVHj7PGM5MjoKBAnTQYHZYa6rfMkAUHrhY+NfES7WLTK3ZPMEgc0fpMm0A6108FCfImnxcflA1FQmEriV341Guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100377; c=relaxed/simple;
	bh=F6io8MIjX4fTCVO4ljtjOwuqCsjutoc6/V6MfGuA82Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KCSolvBYZgMhe8ZdmOwTvGjaVJH3dVW+SDDaJ6mSgnITnXMeaaii2u2KD86Zl/WjQNsmnAWyaNFoLmJlIzy30zOEMAFrnEAECci2iGp55+F/6VoTb/C3gH3kc+Ysyxm2JC6dQwwKzEuB1S5uCvYz2ZUkIWtL36gzvbeSyQw+pzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hccpIyHu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hccpIyHu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMai1P1699404;
	Fri, 14 Nov 2025 06:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F+jU80j4KXpUR151J9f2LqN5NIEEnTChtRbVnOmELXQ=; b=hccpIyHulhGN9ygR
	nS7IdOwIs2+haf6yaMQlDzeZIslLEyEljRdodv+8cw/XQPv7ii8XmzcIU6X4yLAg
	TmlGGaQOHrB2xu+pLRG3KMakx5epVujuLZT6nC37Lgcl/WF0+T9y3TQlUBJ0d41p
	cGEx2BSjJ+JkfbPLBqgGIzHhgJQy4Ge3R6zOFObR+EPquocBn/vb9vFJY2nj2vZe
	puidl0QV6fyXKXNMQA2rflxOeWJMT7eBvXwgxgZNLZcW4lm12pG5JcTWHkaDHrJ3
	xW5GMvX0ZXxOs0LqISIRFDlxC0PCAxlkPCrb/kyy19MPf8FDM2p1GYkEba+p8BRm
	Ibbvdg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e11ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:05:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5AE65som020430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:05:54 GMT
Received: from [10.233.71.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 13 Nov
 2025 22:05:49 -0800
Message-ID: <c978a8b8-7373-4ecd-8a64-84b712b49926@quicinc.com>
Date: Fri, 14 Nov 2025 14:05:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] stm: class: Add MIPI OST protocol support
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tingwei Zhang
	<tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang
	<yuanfang.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
References: <20251024-p_ost-v4-1-3652a06fd055@oss.qualcomm.com>
Content-Language: en-US
From: "Yingchao Deng (Consultant)" <quic_yingdeng@quicinc.com>
In-Reply-To: <20251024-p_ost-v4-1-3652a06fd055@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UvijCNsIVyAUZPaiwLicVrve_8ugcalX
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=6916c6c2 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=6yLz6eykGvcVGgrU5Q4A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UvijCNsIVyAUZPaiwLicVrve_8ugcalX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA0NSBTYWx0ZWRfX65uxYov1KcMj
 2BIpxkZdeAgoP+6RWl1y0Dc26KzhlVQjH2uwPSu/Rh10ouvYGEzwaadKZo22o32DwTRj+py79G2
 ovRujTDcN96mvixbseRbC4z2rvMS9SDhCw7T1h2g2ddCtDg/dssS8GGOEQx4LKJD/kJLO/p7GTg
 txr1JNgdoCo1KEdLJ2pwL6NpIT8uql4H87/Y+1P5DfMb3pCs/EBgRQChX89paQIpTNop7wgrrsu
 hmjE0NqXH0DrM+cQiygLX21or9x3UJCTd0+TCOi0fPrPittu7U5BZ2HLkY3QS55cY0KqQE1/z5N
 yJFKIx3OtXd2oKuHBUVVwYowlNcx8TX2q/3p3z/hLFs/DUHzkJ4rXPN4BpjEjBiZQxxOmk3tAOC
 5mnktG8JoKHKYS8UMgZHe3rT5nXK9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140045


On 10/24/2025 3:05 PM, Yingchao Deng wrote:
> Add MIPI OST(Open System Trace) protocol support for stm to format the
> traces. The OST Protocol abstracts the underlying layers from the sending
> and receiving applications, thus removing dependencies on the connection
> media and platform implementation.
>
> OST over STP packet consists of Header/Payload/End. Header is designed to
> include the information required by all OST packets. Information  that is
> not shared by all packets is left to the higher layer protocols. Thus, the
> OST Protocol Header can be regarded as the first part of a complete OST
> Packet Header, while a higher layer header can be regarded as an extension
> designed for a specific purpose.
>
> +--------+--------+--------+--------+
> | start  |version |entity  |protocol|
> +--------+--------+--------+--------+
> |    stm version  |      magic      |
> +-----------------------------------+
> |                cpu                |
> +-----------------------------------+
> |              timestamp            |
> |                                   |
> +-----------------------------------+
> |                tgid               |
> |                                   |
> +-----------------------------------+
> |               payload             |
> +-----------------------------------+
> |                 ...      |  end   |
> +-----------------------------------+
>
> In header, there will be STARTSIMPLE/VERSION/ENTITY/PROTOCOL.
> STARTSIMPLE is used to signal the beginning of a simplified OST protocol.
> The Version field is a one byte, unsigned number identifying the version
> of the OST Protocol. The Entity ID field is a one byte unsigned number
> that identifies the source.
>
> The Protocol ID field is a one byte unsigned number identifying the higher
> layer protocol of the OST Packet, i.e. identifying the format of the data
> after the OST Protocol Header. OST Control Protocol ID value represents
> the common control protocol, the remaining Protocol ID values may be used
> by any higher layer protocols capable of being transported by the OST
> Protocol.
>
> Signed-off-by: Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> ---
> Changes in v4:
> 1. Delete unused variable 'i'.
> 2. Fix build error: call to undeclared function 'task_tgid_nr'.
> Link to v3 - https://lore.kernel.org/all/20251022071834.1658684-1-yingchao.deng@oss.qualcomm.com/
>
> Changes in v3:
> 1. Add more details about OST.
> 2. Delete 'entity_available' node, and 'entity' node will show available
> and currently selected (shown in square brackets) entity.
> 3. Removed the usage of config_item->ci_group->cg_subsys->su_mutex.
> Link to v2 - https://lore.kernel.org/all/20230419141328.37472-1-quic_jinlmao@quicinc.com/
> ---
>   .../ABI/testing/configfs-stp-policy-p_ost          |   6 +
>   Documentation/trace/p_ost.rst                      |  36 ++++
>   drivers/hwtracing/stm/Kconfig                      |  14 ++
>   drivers/hwtracing/stm/Makefile                     |   2 +
>   drivers/hwtracing/stm/p_ost.c                      | 236 +++++++++++++++++++++
>   5 files changed, 294 insertions(+)
>
> diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_ost b/Documentation/ABI/testing/configfs-stp-policy-p_ost
> new file mode 100644
> index 000000000000..498739b49da0
> --- /dev/null
> +++ b/Documentation/ABI/testing/configfs-stp-policy-p_ost
> @@ -0,0 +1,6 @@
> +What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity
> +Date:		Oct 2025
> +KernelVersion:	6.18
> +Description:
> +		Set the entity which is to identify the source, RW.
> +
> diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
> new file mode 100644
> index 000000000000..df93b889eb4c
> --- /dev/null
> +++ b/Documentation/trace/p_ost.rst
> @@ -0,0 +1,36 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +MIPI OST over STP
> +===================
> +
> +The OST(Open System Trace) driver is used with STM class devices to
> +generate standardized trace stream. Trace sources can be identified
> +by different entity ids.
> +
> +CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
> +is enabled, you can select the p_ost protocol by command below:
> +
> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
> +
> +The policy name format is extended like this:
> +    <device_name>:<protocol_name>.<policy_name>
> +
> +With coresight-stm device, it will be look like "stm0:p_ost.policy".
> +
> +With MIPI OST protocol driver, the attributes for each protocol node is:
> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +channels  entity    masters
> +
> +The entity here is the set the entity that p_ost supports. Currently
> +p_ost supports ftrace, console and diag entity.
> +
> +Set entity:
> +# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
> +
> +Get available and currently selected (shown in square brackets) entity that p_ost supports:
> +# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
> +[ftrace] console diag
> +
> +See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index eda6b11d40a1..daa4aa09f64d 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
>   
>   	  If you don't know what this is, say N.
>   
> +config STM_PROTO_OST
> +	tristate "MIPI OST STM framing protocol driver"
> +	default CONFIG_STM
> +	help
> +	  This is an implementation of MIPI OST protocol to be used
> +	  over the STP transport. In addition to the data payload, it
> +	  also carries additional metadata for entity, better
> +	  means of trace source identification, etc.
> +
> +	  The receiving side must be able to decode this protocol in
> +	  addition to the MIPI STP, in order to extract the data.
> +
> +	  If you don't know what this is, say N.
> +
>   config STM_DUMMY
>   	tristate "Dummy STM driver"
>   	help
> diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
> index 1692fcd29277..d9c8615849b9 100644
> --- a/drivers/hwtracing/stm/Makefile
> +++ b/drivers/hwtracing/stm/Makefile
> @@ -5,9 +5,11 @@ stm_core-y		:= core.o policy.o
>   
>   obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
>   obj-$(CONFIG_STM_PROTO_SYS_T) += stm_p_sys-t.o
> +obj-$(CONFIG_STM_PROTO_OST)   += stm_p_ost.o
>   
>   stm_p_basic-y		:= p_basic.o
>   stm_p_sys-t-y		:= p_sys-t.o
> +stm_p_ost-y		:= p_ost.o
>   
>   obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
>   
> diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
> new file mode 100644
> index 000000000000..ac9492ed5c2c
> --- /dev/null
> +++ b/drivers/hwtracing/stm/p_ost.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * MIPI OST framing protocol for STM devices.
> + */
> +
> +#include <linux/pid.h>
> +#include <linux/sched/clock.h>
> +#include <linux/slab.h>
> +#include <linux/stm.h>
> +#include "stm.h"
> +
> +/*
> + * OST Base Protocol Header
> + *
> + * Position	Bits	Field Name
> + *      0       8       STARTSIMPLE
> + *      1       8       Version
> + *      2       8       Entity ID
> + *      3       8       protocol ID
> + */
> +#define OST_FIELD_STARTSIMPLE		0
> +#define OST_FIELD_VERSION		8
> +#define OST_FIELD_ENTITY		16
> +#define OST_FIELD_PROTOCOL		24
> +
> +#define OST_TOKEN_STARTSIMPLE		0x10
> +#define OST_VERSION_MIPI1		0x10
> +
> +/* entity id to identify the source*/
> +#define OST_ENTITY_FTRACE		0x01
> +#define OST_ENTITY_CONSOLE		0x02
> +#define OST_ENTITY_DIAG			0xEE
> +
> +#define OST_CONTROL_PROTOCOL		0x0
> +
> +#define DATA_HEADER ((OST_TOKEN_STARTSIMPLE << OST_FIELD_STARTSIMPLE) | \
> +		     (OST_VERSION_MIPI1 << OST_FIELD_PROTOCOL) | \
> +		     (OST_CONTROL_PROTOCOL << OST_FIELD_PROTOCOL))
> +
> +#define STM_MAKE_VERSION(ma, mi)	(((ma) << 8) | (mi))
> +#define STM_HEADER_MAGIC		(0x5953)
> +
> +enum ost_entity_type {
> +	OST_ENTITY_TYPE_NONE,
> +	OST_ENTITY_TYPE_FTRACE,
> +	OST_ENTITY_TYPE_CONSOLE,
> +	OST_ENTITY_TYPE_DIAG,
> +};
> +
> +static const char * const str_ost_entity_type[] = {
> +	[OST_ENTITY_TYPE_NONE]		= "none",
> +	[OST_ENTITY_TYPE_FTRACE]	= "ftrace",
> +	[OST_ENTITY_TYPE_CONSOLE]	= "console",
> +	[OST_ENTITY_TYPE_DIAG]		= "diag",
> +};
> +
> +static const u32 ost_entity_value[] = {
> +	[OST_ENTITY_TYPE_NONE]		= 0,
> +	[OST_ENTITY_TYPE_FTRACE]	= OST_ENTITY_FTRACE,
> +	[OST_ENTITY_TYPE_CONSOLE]	= OST_ENTITY_CONSOLE,
> +	[OST_ENTITY_TYPE_DIAG]		= OST_ENTITY_DIAG,
> +};
> +
> +struct ost_policy_node {
> +	enum ost_entity_type	entity_type;
> +};
> +
> +struct ost_output {
> +	struct ost_policy_node	node;
> +};
> +
> +/* Set default entity type as none */
> +static void ost_policy_node_init(void *priv)
> +{
> +	struct ost_policy_node *pn = priv;
> +
> +	pn->entity_type = OST_ENTITY_TYPE_NONE;
> +}
> +
> +static int ost_output_open(void *priv, struct stm_output *output)
> +{
> +	struct ost_policy_node *pn = priv;
> +	struct ost_output *opriv;
> +
> +	opriv = kzalloc(sizeof(*opriv), GFP_ATOMIC);
> +	if (!opriv)
> +		return -ENOMEM;
> +
> +	memcpy(&opriv->node, pn, sizeof(opriv->node));
> +	output->pdrv_private = opriv;
> +	return 0;
> +}
> +
> +static void ost_output_close(struct stm_output *output)
> +{
> +	kfree(output->pdrv_private);
> +}
> +
> +static ssize_t ost_t_policy_entity_show(struct config_item *item,
> +					char *page)
> +{
> +	struct ost_policy_node *pn = to_pdrv_policy_node(item);
> +	ssize_t sz = 0;
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(str_ost_entity_type); i++) {
> +		if (i == pn->entity_type)
> +			sz += sysfs_emit_at(page, sz, "[%s] ", str_ost_entity_type[i]);
> +		else
> +			sz += sysfs_emit_at(page, sz, "%s ", str_ost_entity_type[i]);
> +	}
> +
> +	sz += sysfs_emit_at(page, sz, "\n");
> +	return sz;
> +}
> +
> +static int entity_index(const char *str)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(str_ost_entity_type); i++) {
> +		if (sysfs_streq(str, str_ost_entity_type[i]))
> +			return i;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +ost_t_policy_entity_store(struct config_item *item, const char *page,
> +			  size_t count)
> +{
> +	struct ost_policy_node *pn = to_pdrv_policy_node(item);
> +	int i;
> +
> +	i = entity_index(page);
> +	if (i)
> +		pn->entity_type = i;
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(ost_t_policy_, entity);
> +
> +static struct configfs_attribute *ost_t_policy_attrs[] = {
> +	&ost_t_policy_attr_entity,
> +	NULL,
> +};
> +
> +static ssize_t
> +notrace ost_write(struct stm_data *data, struct stm_output *output,
> +		  unsigned int chan, const char *buf, size_t count,
> +		  struct stm_source_data *source)
> +{
> +	struct ost_output *op = output->pdrv_private;
> +	unsigned int c = output->channel + chan;
> +	unsigned int m = output->master;
> +	const unsigned char nil = 0;
> +	u32 header = DATA_HEADER;
> +	struct trc_hdr {
> +		u16 version;
> +		u16 magic;
> +		u32 cpu;
> +		u64 timestamp;
> +		u64 tgid;
> +	} hdr;
> +	ssize_t sz;
> +
> +	/*
> +	 * Identify the source by entity type.
> +	 * If entity type is not set, return error value.
> +	 */
> +	if (op->node.entity_type)
> +		header |= ost_entity_value[op->node.entity_type];
> +	else
> +		return -EINVAL;
> +
> +	/*
> +	 * STP framing rules for OST frames:
> +	 *   * the first packet of the OST frame is marked;
> +	 *   * the last packet is a FLAG with timestamped tag.
> +	 */
> +	/* Message layout: HEADER / DATA / TAIL */
> +	/* HEADER */
> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
> +			  4, (u8 *)&header);
> +	if (sz <= 0)
> +		return sz;
> +
> +	/* DATA */
> +	hdr.version	= STM_MAKE_VERSION(0, 3);
> +	hdr.magic	= STM_HEADER_MAGIC;
> +	hdr.cpu		= raw_smp_processor_id();
> +	hdr.timestamp	= sched_clock();
> +	hdr.tgid	= task_tgid_nr(current);
> +	sz = stm_data_write(data, m, c, false, &hdr, sizeof(hdr));
> +	if (sz <= 0)
> +		return sz;
> +
> +	sz = stm_data_write(data, m, c, false, buf, count);
> +
> +	/* TAIL */
> +	if (sz > 0)
> +		data->packet(data, m, c, STP_PACKET_FLAG,
> +			STP_PACKET_TIMESTAMPED, 0, &nil);
> +
> +	return sz;
> +}
> +
> +static const struct stm_protocol_driver ost_pdrv = {
> +	.owner			= THIS_MODULE,
> +	.name			= "p_ost",
> +	.write			= ost_write,
> +	.policy_attr		= ost_t_policy_attrs,
> +	.output_open		= ost_output_open,
> +	.output_close		= ost_output_close,
> +	.policy_node_init	= ost_policy_node_init,
> +};
> +
> +static int ost_stm_init(void)
> +{
> +	return stm_register_protocol(&ost_pdrv);
> +}
> +module_init(ost_stm_init);
> +
> +static void ost_stm_exit(void)
> +{
> +	stm_unregister_protocol(&ost_pdrv);
> +}
> +module_exit(ost_stm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MIPI Open System Trace STM framing protocol driver");
>
> ---
> base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
> change-id: 20251024-p_ost-d5052b4a3173
>
> Best regards,

Gentle reminder.

thanks,
Yingchao.

